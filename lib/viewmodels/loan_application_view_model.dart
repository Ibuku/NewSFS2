import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:sfscredit/models/bank.dart';
import 'package:sfscredit/models/bank_details.dart';
import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/models/user_card.dart';
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

  BankDetails _userBankDetails;
  BankDetails get bankDetails => _userBankDetails;

  List<Bank> _banksList = [];
  List get banks => _banksList;

  Bank _selectedBank;
  Bank get selectedBank => _selectedBank;

  List<UserCard> _userCards = [];
  List get cards => _userCards;

  UserCard _selectedCard;
  UserCard get selectedCard => _selectedCard;

  void setSelectedBank(Bank bank) {
    _selectedBank = bank;
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

  Future<void> getAllLoanPackages() async {
    var approvedLoanPackagesRes = await _application.getApprovedLoanPackages();
    if (approvedLoanPackagesRes is Error) {
      _dialogService.showDialog(
        title: "Network error occured",
        description: approvedLoanPackagesRes.toString(),
      );
      return;
    }
    if (approvedLoanPackagesRes.statusCode == 200) {
      var body = jsonDecode(approvedLoanPackagesRes.body);
      List approvedLoanPackages = body['data'];
      _loanPackages = approvedLoanPackages.map((i) => LoanPackage.fromMap((i))).toList();
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: approvedLoanPackagesRes.toString(),
      );
    }
  }

  Future<void> getAllBanks() async {
    var allBanksRes = await _application.getBanks();
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

  Future<void> getUsersBankDetails() async {
    var bankDetailsRes = await _application.getUsersBankDetails();
    if(bankDetailsRes.runtimeType == Response) {
      if (bankDetailsRes.statusCode == 200) {
        var body = jsonDecode(bankDetailsRes.body);
        if(!body['data'].isEmpty) {
          _userBankDetails = BankDetails.fromMap(body['data'][0]);
        }
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: bankDetailsRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: bankDetailsRes.toString(),
      );
    }
  }

  Future<void> getUsersCards() async {
    var cardsRes = await _application.getUsersCards();
    if(cardsRes.runtimeType == Response) {
      if (cardsRes.statusCode == 200) {
        var body = jsonDecode(cardsRes.body);
        List verifiedCards = body['data'];
        _userCards = verifiedCards.map((i) => UserCard.fromMap((i))).toList();
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
    print("Request Data: $reqData");
  }

  Future<void> initPackages() async {
    setLoading(true);
    await getAllLoanPackages();
    setLoading(false);
  }

  Future<void> init() async {
    setLoading(true);
    await Future.wait([getAllBanks(), getUsersBankDetails(), getUsersCards()]);
    setLoading(false);
  }
}
