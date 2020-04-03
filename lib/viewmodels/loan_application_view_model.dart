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

  List<UserCard> _userCards = [];
  List get cards => _userCards;

  UserCard _selectedCard;
  UserCard get selectedCard => _selectedCard;

  void setLoanPackages(List<LoanPackage> packages) {
    _loanPackages = packages;
    notifyListeners();
  }

  void setUserCards(List<UserCard> cards) {
    _userCards = cards;
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

  Future<void> getUsersCards() async {
    var cardsRes = await _application.getUsersCards();
    if(cardsRes.runtimeType == Response) {
      if (cardsRes.statusCode == 200) {
        var body = jsonDecode(cardsRes.body);
        List verifiedCards = body['data'];
        setUserCards(verifiedCards.map((i) => UserCard.fromMap((i))).toList());
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: cardsRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: cardsRes.toString(),
      );
    }
  }

  Future<void> makeLoanRequest({@required Map reqData}) async {
    reqData['current_salary'] = reqData['current_salary'].toString();
    var loanRequestRes = await _application.requestForALoan(loanReqData: reqData);
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
          description: body['message'].toString(),
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
    await Future.wait([getAllBanks(), getUsersCards(), getUsersBankDetails()]);
    setLoading(false);
  }
}
