import 'dart:convert';

import 'package:http/http.dart';
import 'package:sfscredit/models/bank.dart';
import 'package:sfscredit/models/bank_details.dart';

import '../viewmodels/application_view_model.dart';
import '../services/dialog_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

class ProfileViewModel extends ApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final ApplicationService _applicationService = locator<ApplicationService>();

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;

  void setPasswordVisible(bool val) {
    _passwordVisible = val;
    notifyListeners();
  }

  Future updateUser(Map _userProfile) async {
    setBusy(true);

    var result = await _applicationService.updateUserProfile(_userProfile);

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        setBusy(true);
        await ApplicationViewModel().getUserProfile();
        setBusy(false);
        _dialogService.showDialog(
          title: "Profile Update Successful",
          description: body['message'],
        );
      } else if (result.statusCode == 400) {
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
        description: result,
      );
    }
  }

  Future updateUserBankDetails(Map reqData) async {
    setBusy(true);
    var addDetailsRes = await _applicationService.addBankDetails(reqData);
    if(addDetailsRes.runtimeType == Response) {
      var body = jsonDecode(addDetailsRes.body);
      if (addDetailsRes.statusCode == 200) {
        setBusy(true);
        await getUsersBankDetails();
        setBusy(false);
      } else {
        _dialogService.showDialog(
            title: "Bank Details Update Failed",
            description: body['message']
        );
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
