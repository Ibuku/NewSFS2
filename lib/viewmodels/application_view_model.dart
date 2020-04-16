import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:sfscredit/models/bank.dart';
import 'package:sfscredit/models/bank_details.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/models/loan_request.dart';
import 'package:sfscredit/models/payback_schedule.dart';
import 'package:sfscredit/models/user_card.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/views/auth/login_screen.dart';

import '../models/user.dart';

import '../services/local_storage_service.dart';
import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'base_model.dart';

class ApplicationViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();
  final LocalStorageService _storageService = locator<LocalStorageService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  int _totalGuarantorLoanPayback = 0;
  int get totalGuarantorLoan => _totalGuarantorLoanPayback;

  int _userWallerBalance = 0;
  int get walletBalance => _userWallerBalance;

  User _user;
  User get user {
    _user = _application.getUser;
    return _user;
  }

  set user(userJson) {
    _authenticationService.loadUser(userJson);
    ApplicationService.user = User.fromJson(userJson);
  }

  List<LoanPackage> _loanPackages = [];
  List get loanPackages => _loanPackages;

  void setLoanPackages(List<LoanPackage> packages) {
    _loanPackages = packages;
    notifyListeners();
  }

  List<LoanRequest> _userLoanRequests = [];
  List<LoanRequest> get loanRequests => _userLoanRequests;

  void setUserLoanRequests(List<LoanRequest> requests) {
    _userLoanRequests = requests;
    notifyListeners();
  }

  int _activeLoansTotal = 0;
  int get activeLoansTotal => _activeLoansTotal;

  int _activeLoansAmountLeft = 0;
  int get activeLoansAmountLeft => _activeLoansAmountLeft;

  int _activeLoansTotalPaid = 0;
  int get activeLoansTotalPaid => _activeLoansTotalPaid;

  void setActiveLoanParams(
      List<PaybackSchedule> pendingSchedules, List<LoanRequest> requests) {
    List rawSchedules =
        pendingSchedules.map((schedule) => schedule.toMap()).toList();
    List rawRequests = requests.map((request) => request.toMap()).toList();
    print("Pending Schedules: ${rawSchedules}");
    print("Loan Requests: ${rawRequests}");
    requests.forEach((request) {
      _activeLoansTotal += request.loanPackage.totalPayback;
      _activeLoansAmountLeft += pendingSchedules
          .where((schedule) => schedule.loanRequestId == request.id)
          .map((sch) => sch.amountDue)
          .reduce((int i, int j) => i + j);
    });
    _activeLoansTotalPaid = _activeLoansTotal - _activeLoansAmountLeft;
    notifyListeners();
  }

  BankDetails _userBankDetails;
  BankDetails get bankDetails => _userBankDetails;

  String _bankAccountName = "";
  String get bankAccountName => _bankAccountName;

  List<Bank> _banksList = [];
  List get banks => _banksList;

  Bank _selectedBank;
  Bank get selectedBank => _selectedBank;

  void setSelectedBank(Bank bank) {
    _selectedBank = bank;
  }

  void setBankDetails(BankDetails details) {
    _userBankDetails = details;
    _bankAccountName = details.accountName;
    notifyListeners();
  }

  List<UserCard> _userCards = [];
  List get cards => _userCards;

  void setUserCards(List<UserCard> cards) {
    _userCards = cards;
    notifyListeners();
  }

  BuildContext _context;

  BuildContext get context => _context;

  void setBuildContext(BuildContext context) {
    _context = context;
  }

  Future<void> getUserProfile() async {
    var userProfile = await _application.userProfile();
    if (userProfile is Error) {
      _dialogService.showDialog(
        title: "Network error occured",
        description: userProfile.toString(),
      );
      return;
    }
    if (userProfile.statusCode == 200) {
      var body = jsonDecode(userProfile.body);
      user = body['data'];
    }
  }

  void toRoute(String type) {
    switch (type) {
      case UpdateKYC.routeName:
        _navigationService.navigateTo(UpdateKYC.routeName);
        break;
      default:
        _navigationService.navigateTo(type);
        break;
    }
  }

  Future<void> getWalletBalance() async {
    var walletRequestRes = await _application.getWallet();
    if (walletRequestRes is Error) {
      _dialogService.showDialog(
        title: "Network error occured",
        description: walletRequestRes.toString(),
      );
      return;
    }
    if (walletRequestRes.statusCode == 200) {
      var body = jsonDecode(walletRequestRes.body)['data'];
      _userWallerBalance = body['balance'];
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: walletRequestRes.toString(),
      );
    }
  }

  Future<void> getTotalGuarantorLoan() async {
    var guarantorRequestsRes = await _application.getGuarantorRequests();

    if (guarantorRequestsRes.runtimeType == Response) {
      var body = jsonDecode(guarantorRequestsRes.body);
      if (guarantorRequestsRes.statusCode == 200) {
        List rawRequests = body['data'];
        List<GuarantorRequest> allGuarantorRequests =
            rawRequests.map((req) => GuarantorRequest.fromMap(req)).toList();
        List<GuarantorRequest> approvedRequests = allGuarantorRequests
            .where((req) => req.guarantorApproved == 'approved')
            .toList();
        if (approvedRequests.length > 0) {
          int guaranteedLoansTotal = approvedRequests
              .map((req) => req.loanRequest.loanPackage.totalPayback)
              .reduce((int i, int j) => i + j);
          _totalGuarantorLoanPayback = guaranteedLoansTotal;
        }
      } else {
        _dialogService.showDialog(
          title: "Request Error",
          description: body['message'],
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: guarantorRequestsRes.toString(),
      );
    }
  }

  Future<void> getUserLoanRequests() async {
    setLoading(true);
    var allLoanRequestsRes = await _application.getLoanRequests();
    if (allLoanRequestsRes.runtimeType == Response) {
      if (allLoanRequestsRes.statusCode == 200) {
        var body = jsonDecode(allLoanRequestsRes.body);
        List allLoanRequests = body['data'];
        List<LoanRequest> userLoanRequestList =
            allLoanRequests.map((i) => LoanRequest.fromMap(i)).toList();
        setUserLoanRequests(userLoanRequestList);
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: allLoanRequestsRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: allLoanRequestsRes.toString(),
      );
    }
    setLoading(false);
  }

  Future getLoanPaybackSchedules(List<LoanRequest> requests) async {
    var paybackSchedulesRes = await _application.getPaybackSchedules();
    if (paybackSchedulesRes.runtimeType == Response) {
      if (paybackSchedulesRes.statusCode == 200) {
        var body = jsonDecode(paybackSchedulesRes.body);
        if (!body['data'].isEmpty) {
          List rawRequests = body['data'];
          List<PaybackSchedule> pendingSchedules = rawRequests
              .where((schedule) => schedule['payment_status'] == 'pending')
              .map((i) => PaybackSchedule.fromMap((i)))
              .toList();
          setActiveLoanParams(pendingSchedules, requests);
        }
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: paybackSchedulesRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: paybackSchedulesRes.toString(),
      );
    }
  }

  Future getAllLoanPackages(Function setLoanPackages) async {
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
      List<LoanPackage> loanPackages =
          approvedLoanPackages.map((i) => LoanPackage.fromMap((i))).toList();
      print("Loan packages : ${body['data']}");
      setLoanPackages(loanPackages);
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: approvedLoanPackagesRes.toString(),
      );
    }
  }

  Future<void> getUsersBankDetails() async {
    setBusy(true);
    await getAllBanks();
    var bankDetailsRes = await _application.getUsersBankDetails();
    setBusy(false);

    if (bankDetailsRes.runtimeType == Response) {
      if (bankDetailsRes.statusCode == 200) {
        var body = jsonDecode(bankDetailsRes.body);
        if (!body['data'].isEmpty) {
          List rawData = body['data'];
          List<BankDetails> details = rawData.map((detailsMap) {
            Bank userBank = banks
                .firstWhere((bank) => bank.code == detailsMap['bank_code']);
            return BankDetails.fromMap(
                {...detailsMap, 'bank_name': userBank.name});
          }).toList();
          setBankDetails(details[0]);
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

  Future<void> getAllBanks() async {
    setBusy(true);
    var allBanksRes = await _application.getBanks();
    setBusy(false);

    if (allBanksRes.runtimeType == Response) {
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
    var resolveDetailsRes =
        await _application.resolveBankDetails(accountNo, bank.code);
    if (resolveDetailsRes.runtimeType == Response) {
      var body = jsonDecode(resolveDetailsRes.body);
      if (resolveDetailsRes.statusCode == 200) {
        if (!body['data'].isEmpty) {
          setBankDetails(BankDetails.fromMap(body['data']));
        }
      } else {
        _dialogService.showDialog(
            title: "Bank Account Verification Failed",
            description: body['message']);
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

  Future<void> getUsersCards() async {
    setBusy(true);
    var cardsRes = await _application.getUsersCards();
    setBusy(false);

    if (cardsRes.runtimeType == Response) {
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

  Future<void> init() async {
    setLoading(true);
    await Future.wait([getUserLoanRequests()]);
    await Future.wait([
      getWalletBalance(),
      getTotalGuarantorLoan(),
      getLoanPaybackSchedules(_userLoanRequests)
    ]);
    setLoading(false);
  }

  Future<bool> onWillPop() async {
    bool ans = false;
    await _dialogService
        .showConfirmationDialog(
      title: "Confirm Action !",
      description: "Do you want to exit SFS Credit",
      cancelTitle: "No",
      confirmationTitle: "Yes",
    )
        .then((val) {
      ans = val.confirmed;
    });
    return ans;
  }

  Future<bool> logout() async {
    bool ans = false;
    await _dialogService
        .showConfirmationDialog(
      title: "Confirm Action !",
      description: "Do you want to logout from SFS Credit",
      cancelTitle: "No",
      confirmationTitle: "Yes",
    )
        .then(
      (val) {
        ans = val.confirmed;
        if (val.confirmed == true) {
          _storageService.empty();
          _dialogService.showDialog(
              title: "Logout", description: "Logout successful");
          _navigationService.navigateAndClearRoute(LoginScreen.routeName);
        }
      },
    );
    return ans;
  }

  String formatNumber(int num) {
    return new NumberFormat('###,###').format(num);
  }

  void showMessage(String title, String description) {
    _dialogService.showDialog(title: title, description: description);
  }

  void prettyPrint(json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pprint = encoder.convert(json);
    print(pprint);
  }
}
