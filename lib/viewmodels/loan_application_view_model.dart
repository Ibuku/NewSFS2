import 'dart:convert';

import 'package:sfscredit/models/loan_package.dart';
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

  void toRoute(String type) {
    switch (type) {
      case UpdateKYC.routeName:
        _navigationService.navigateTo(UpdateKYC.routeName);
        break;
      default:
    }
  }

  Future<void> getAllLoanPackages() async {
    var allLoanPackagesRes = await _application.getLoanPackages();
    if (allLoanPackagesRes is Error) {
      _dialogService.showDialog(
        title: "Network error occured",
        description: allLoanPackagesRes.toString(),
      );
      return;
    }
    if (allLoanPackagesRes.statusCode == 200) {
      var body = jsonDecode(allLoanPackagesRes.body);
      List allLoanPackages = body['data'];
      _loanPackages = allLoanPackages.map((i) => LoanPackage.fromMap((i))).where((loanPackage) => loanPackage.status == 'approved').toList();
    } else {
      _dialogService.showDialog(
        title: "Network error occured",
        description: allLoanPackagesRes.toString(),
      );
    }
  }

  Future<void> init() async {
    setLoading(true);
    await getAllLoanPackages();
    setLoading(false);
  }
}
