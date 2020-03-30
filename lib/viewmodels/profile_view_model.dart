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

  List<Bank> _banksList = [];
  List get banks => _banksList;

  Bank _selectedBank;
  Bank get selectedBank => _selectedBank;

  void setSelectedBank(Bank bank) {
    _selectedBank = bank;
  }

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

  Future<void> getAllBanks() async {
    setBusy(true);
    var allBanksRes = await _applicationService.getBanks();
    setBusy(false);

    if(allBanksRes.runtimeType == Response) {
      if (allBanksRes.statusCode == 200) {
        var body = jsonDecode(allBanksRes.body);
        List allBanks = body['data'];
        _banksList = allBanks.map((i) => Bank.fromMap((i))).toList();
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: allBanksRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: allBanksRes.toString(),
      );
    }
  }

  Future<void> resolveBankDetails(String accountNo, Bank bank) async {
    setBusy(true);
    var resolveDetailsRes = await _applicationService.resolveBankDetails(accountNo, bank.code);
    if(resolveDetailsRes.runtimeType == Response) {
      var body = jsonDecode(resolveDetailsRes.body);
      if (resolveDetailsRes.statusCode == 200) {
        if(!body['data'].isEmpty) {
          setBankDetails(BankDetails.fromMap(body['data']));
        }
      } else {
        _dialogService.showDialog(
            title: "Bank Account Verification Failed",
            description: body['message']
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: resolveDetailsRes.toString(),
      );
    }
    setBusy(false);
  }

  Future<void> initBankDetails() async {
    setLoading(true);

    await Future.wait([getAllBanks(), getUsersBankDetails()]);

    setLoading(false);
  }

  Future updateUserBankDetails(Map reqData) async {
    setBusy(true);
    var addDetailsRes = await _applicationService.addBankDetails(reqData);
    if(addDetailsRes.runtimeType == Response) {
      var body = jsonDecode(addDetailsRes.body);
      if (addDetailsRes.statusCode == 200) {
        setBusy(true);
        await getUsersBankDetails();
        print("Detils: $bankDetails");
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
