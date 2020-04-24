import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/company.dart';

import '../ui/views/auth/verify/activate_account.dart';
import '../ui/views/auth/signup/register_screen.dart';

import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../locator.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Company _selectedCompany;
  Company get selectedCompany => _selectedCompany;
  List<Company> _companiesList = [];
  List get companies => _companiesList;
  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;
  bool _password2Visible = true;
  bool get password2Visible => _password2Visible;

  void setPasswordVisible(bool val, {int type = 1}) {
    type == 1 ? _passwordVisible = val : _password2Visible = val;
    notifyListeners();
  }

  Future init() async {
    setLoading(true);

    var companyRes = await _authenticationService.getCompanies();

    if (companyRes != null) {
      if (companyRes.statusCode == 200) {
        var body = jsonDecode(companyRes.body);
        List companies = body['data'];
        _companiesList = companies.map((i) => Company.fromMap(i)).toList();
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: companyRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: companyRes.toString(),
      );
    }

    setLoading(false);
  }

  void setSelectedCompany(Company company) {
    _selectedCompany = company;
    notifyListeners();
  }

  Future signUp({
    @required Map authData,
  }) async {
    setBusy(true);

    authData['company_id'] = selectedCompany.id.toString();

    var result = await _authenticationService.authenticate(
        authData: authData, type: "register");

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        _navigationService.navigateTo(ActivateAccount.routeName,
            replace: true, arguments: authData['email']);
      } else if (result.statusCode == 400) {
        print("400 Error: $body");
        await _dialogService.showDialog(
          title: 'Sign Up Failed',
          description: body['message'],
        );
      } else {
        print("Error: $body");
        await _dialogService.showDialog(
          title: 'Sign Up Failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failed',
        description: result,
      );
    }
  }

  void showSignupForm() {
    if (selectedCompany != null) {
      _navigationService.navigateTo(
        RegisterScreen.routeName,
        arguments: selectedCompany,
      );
    } else {
      _dialogService.showDialog(
        title: "Validation error",
        description: "You have not selected a company",
      );
    }
  }
}