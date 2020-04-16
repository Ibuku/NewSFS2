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
    var fileRes = await _applicationService.uploadAvatarFile(
        {'avatar': await dio.MultipartFile.fromFile(avatarImage.path)});
    setBusy(false);

    if (fileRes.runtimeType == dio.Response) {
      var fileBody = fileRes.data;
      if (fileRes.statusCode == 200) {
        Map userProfileData = fileBody['data'];
        Map userJson = userProfileData.remove('user');
        userJson['user_profile'] = userProfileData;
        user = userJson;
        _dialogService.showDialog(
          title: "Profile Avatar Update Successful",
          description: fileBody['message'],
        );
      } else {
        _dialogService.showDialog(
          title: "Error with Avatar Image Upload",
          description: fileBody['message'],
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application Error with Avatar Image Upload",
        description: fileRes.toString(),
      );
    }
  }

  Future updateUser(Map _userProfile) async {
    setBusy(true);

    var profileRes = await _applicationService.updateUserProfile(_userProfile);

    setBusy(false);

    if (profileRes.runtimeType == Response) {
      var body = jsonDecode(profileRes.body);
      if (profileRes.statusCode == 200) {
        setBusy(true);
        await ApplicationViewModel().getUserProfile();
        setBusy(false);
        await _dialogService.showDialog(
          title: "Profile Update Successful",
          description: body['message'],
        );
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

  Future updateUserBankDetails(
    Map reqData,
  ) async {
    setBusy(true);
    var addDetailsRes = await _applicationService.addBankDetails(reqData);
    if (addDetailsRes.runtimeType == Response) {
      var body = jsonDecode(addDetailsRes.body);
      if (addDetailsRes.statusCode == 200) {
        _dialogService.showDialog(
            title: "Bank Details", description: body['message']);
        return "success";
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
