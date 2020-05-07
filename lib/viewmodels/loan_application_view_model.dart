import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/models/user_card.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';

import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'application_view_model.dart';

class LoanApplicationViewModel extends ApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();

  List<LoanPackage> _loanPackages = [];
  List get loanPackages => _loanPackages;

  UserCard _selectedCard;
  UserCard get selectedCard => _selectedCard;

  void setLoanPackages(List<LoanPackage> packages) {
    _loanPackages = packages;
    notifyListeners();
  }

  void setSelectedCard(UserCard card) {
    _selectedCard = card;
    notifyListeners();
  }

  void toRoute(String type) {
    switch (type) {
      case UpdateKYC.routeName:
        _navigationService.navigateTo(UpdateKYC.routeName);
        break;
      default:
    }
  }

  Future<void> makeLoanRequest({@required Map reqData}) async {
    reqData['current_salary'] = reqData['current_salary'].toString();
    setBusy(true);
    var loanRequestRes = await _application.requestForALoan(loanReqData: reqData);
    setBusy(false);
    if(loanRequestRes.runtimeType == Response){
      var body = jsonDecode(loanRequestRes.body);
      if(loanRequestRes.statusCode == 200){
        _dialogService.showDialog(
          title: "Loan Request Successful",
          description: "Request under review...",
        );
        _navigationService.navigateAndClearRoute(DashboardScreen.routeName);
      } else {
        _dialogService.showDialog(
          title: "Failed to make a Loan Request",
          description: body['message'] ?? "Service Unavailable",
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: loanRequestRes.toString(),
      );
    }
  }

  Future<void> initPackages() async {
    setLoading(true);
    await super.getAllLoanPackages(setLoanPackages);
    setLoading(false);
  }

  Future<void> initLoanApplication() async {
    setLoading(true);
    await Future.wait([getAllBanks(), getUsersCards()]);
    setLoading(false);
  }
}
