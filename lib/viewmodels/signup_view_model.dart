import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sfscredit/models/company.dart';

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

  Future init() async {
    setLoading(true);

    var companyRes = await _authenticationService.getCompanies();
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

    setLoading(false);
  }

  void setSelectedCompany(Company company) {
    _selectedCompany = company;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      companyID: _selectedCompany.id,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo("");
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}
