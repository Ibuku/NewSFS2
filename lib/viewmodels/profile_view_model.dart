import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:sfscredit/services/navigation_service.dart';

import '../viewmodels/application_view_model.dart';
import '../services/dialog_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

class ProfileViewModel extends ApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final ApplicationService _applicationService = locator<ApplicationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;

  void setPasswordVisible(bool val) {
    _passwordVisible = val;
    notifyListeners();
  }

  Future uploadUserAvatarFile(File avatarImage) async {
    setBusy(true);
    var fileRes = await _applicationService.uploadFile2(
        {'uploadFile': await dio.MultipartFile.fromFile(avatarImage.path)});
    setBusy(false);

    if (fileRes.runtimeType == dio.Response) {
      var fileBody = fileRes.data;
      if (fileRes.statusCode == 200) {
        return fileBody['data'];
      } else {
        _dialogService.showDialog(
          title: "Error with Image Upload",
          description: fileBody['message'],
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application Error with Image Upload",
        description: fileRes.toString(),
      );
    }
  }

  Future updateUser(Map _userProfile, File avatarImage) async {
    List<Future> requests = [
      _applicationService.updateUserProfile(_userProfile)
    ];
    if (avatarImage != null) {
      String avatarUrl;
      try {
        avatarUrl = await uploadUserAvatarFile(avatarImage);
      } catch (e) {
        return e;
      }
      requests.add(_applicationService.uploadUserAvatar({'avatar': avatarUrl}));
    }
    setBusy(true);

    var results = await Future.wait(requests);

    setBusy(false);

    var profileRes = results[0];
    var avatarRes;
    if (avatarImage != null) {
      avatarRes = results[1];
    }

    if (profileRes.runtimeType == Response) {
      var body = jsonDecode(profileRes.body);
      if (profileRes.statusCode == 200) {
        setBusy(true);
        await ApplicationViewModel().getUserProfile();
        setBusy(false);
        if (avatarRes != null) {
          if (avatarRes.runtimeType == Response) {
            var fileBody = jsonDecode(avatarRes.body);
            if (avatarRes.statusCode == 200) {
              _dialogService.showDialog(
                title: "Profile Update Successful",
                description: body['message'],
              );
            } else {
              print("FileBody: $fileBody");
              _dialogService.showDialog(
                title: "Error with Profile Avatar Update",
                description: fileBody['message'] ?? "Error",
              );
            }
          } else {
            _dialogService.showDialog(
              title: "Application Error with Profile Avatar Update",
              description: avatarRes.toString(),
            );
          }
        } else {
          _dialogService.showDialog(
            title: "Profile Update Successful",
            description: body['message'],
          );
        }
      } else if (profileRes.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'Profile Update failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title: 'Profile Update failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Application error',
        description: profileRes,
      );
    }
  }

  Future updateUserBankDetails(Map reqData) async {
    setBusy(true);
    var addDetailsRes = await _applicationService.addBankDetails(reqData);
    if (addDetailsRes.runtimeType == Response) {
      var body = jsonDecode(addDetailsRes.body);
      if (addDetailsRes.statusCode == 200) {
        setBusy(true);
        await getUsersBankDetails();
        setBusy(false);
        _navigationService.pop();
      } else {
        _dialogService.showDialog(
            title: "Bank Details Update Failed", description: body['message']);
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: addDetailsRes.toString(),
      );
    }
    setBusy(false);
  }
}
