import 'dart:convert';

import 'package:sfscredit/models/loan.dart';
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

  int _activeLoanPayback = 0;
  int get activeLoan => _activeLoanPayback;

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

  Future<void> getUserProfile() async {
    var userProfile = await _application.userProfile();
    if (userProfile.statusCode == 200) {
      var body = jsonDecode(userProfile.body);
      user = body['data'];
      // _authenticationService.loadUser(body['data']);
      // ApplicationService.user = User.fromJson(body['data']);
    }
  }

  void toRoute(String type) {
    switch (type) {
      case UpdateKYC.routeName:
        _navigationService.navigateTo(UpdateKYC.routeName);
        break;
      default:
    }
  }

  Future<void> getActiveLoan() async {
    var allLoanRequestsRes = await _application.getActiveLoanRequests();
    if (allLoanRequestsRes is Error) {
      _dialogService.showDialog(
        title: "Network error occured",
        description: allLoanRequestsRes.toString(),
      );
      return;
    }
    if (allLoanRequestsRes.statusCode == 200) {
      var body = jsonDecode(allLoanRequestsRes.body);
      List allLoanRequests = body['data'];
      User authenticatedUser = _application.getUser;
      List userLoanRequests = allLoanRequests.where((loanRequest) => loanRequest.user_id == authenticatedUser.id && loanRequest.status == 'approved').toList();
      List<Loan> userLoanList = userLoanRequests.map((i) => Loan.fromMap(i)).toList();
      if(userLoanList.length != 0){
        Loan currentActiveLoan = new List.from(userLoanList.reversed)[0];
        _activeLoanPayback = currentActiveLoan.totalPayback;
      }
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: allLoanRequestsRes.toString(),
      );
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

  Future<void> init() async {
    setLoading(true);

    await getActiveLoan();
    await getWalletBalance();

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
        if(val.confirmed == true){
          _storageService.empty();
          _dialogService.showDialog(title: "Logout", description: "Logout successful");
          _navigationService.navigateAndClearRoute(LoginScreen.routeName);
        }
      },
    );
    return ans;
  }
}
