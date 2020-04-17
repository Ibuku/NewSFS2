import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';

import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';

import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'application_view_model.dart';

class GuarantorRequestViewModel extends ApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();

  List<GuarantorRequest> _guarantorRequests = [];
  List<GuarantorRequest> get guarantorRequests => _guarantorRequests;

  void setGuarantorRequests(List<GuarantorRequest> requests) {
    _guarantorRequests = requests;
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

  Future getGuarantorRequests() async {
    var guarantorRequestRes = await _application.getGuarantorRequests();
    if (guarantorRequestRes.runtimeType == Response) {
      if (guarantorRequestRes.statusCode == 200) {
        var body = jsonDecode(guarantorRequestRes.body);
        if (!body['data'].isEmpty) {
          List rawRequests = body['data'];
          List<GuarantorRequest> requests =
              rawRequests.map((i) => GuarantorRequest.fromMap((i))).toList();
          setGuarantorRequests(requests);
        }
      } else {
        _dialogService.showDialog(
          title: "Network error occured",
          description: guarantorRequestRes.toString(),
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: guarantorRequestRes.toString(),
      );
    }
  }

  Future modifyGuarantorRequest(
      {@required Map reqData, @required action}) async {
    setBusy(true);

    var modifyGuarantorRequestRes = await _application
        .approveOrDeclineLoanRequest(reqData: reqData, action: action);
    if (modifyGuarantorRequestRes.runtimeType == Response) {
      var body = jsonDecode(modifyGuarantorRequestRes.body);
      print("Req Data: $reqData");
      if (modifyGuarantorRequestRes.statusCode == 200) {
        if (action == 'approve') {
          await cashDownPaymentDialog(reqData['loan_request_id']);
        } else {
          _dialogService.showDialog(
              title: "Guarantor Request", description: body['message']);
          _navigationService.navigateAndClearRoute(AllRequestScreen.routeName);
        }
      } else {
        _dialogService.showDialog(
          title: "Request error occured",
          description: body['message'],
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: modifyGuarantorRequestRes.toString(),
      );
    }
    setBusy(false);
  }

  Future<void> addGuarantorBankDetails({@required Map reqData}) async {
    setBusy(true);
    var addGuarantorDetailsRes =
        await _application.addGuarantorBankDetails(reqData: reqData);
    if (addGuarantorDetailsRes.runtimeType == Response) {
      var body = jsonDecode(addGuarantorDetailsRes.body);
      if (addGuarantorDetailsRes.statusCode == 200) {
        await modifyGuarantorRequest(
            reqData: {'loan_request_id': reqData['loan_request_id']},
            action: 'approve');
      } else {
        _dialogService.showDialog(
          title: "Request error occured",
          description: body['message'],
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: addGuarantorDetailsRes.toString(),
      );
    }

    setBusy(false);
  }

  @override
  Future<void> init() async {
    setLoading(true);

    await getGuarantorRequests();

    setLoading(false);
  }

  Future<bool> cashDownPayment({@required Map reqData}) async {
    setBusy(true);
    var cashDownRes = await _application.cashDownPayment(reqData);
    setBusy(false);

    if (cashDownRes.runtimeType == Response) {
      var body = jsonDecode(cashDownRes.body);
      if (cashDownRes.statusCode == 200) {
        return true;
      } else {
        print("Error: ${body['message']}");
      }
    } else {
      print("App Error: $cashDownRes");
    }
    return false;
  }

  Future cashDownPaymentDialog(String loanRequestId) async {
    String ans = "";
    await _dialogService
        .showConfirmationDialog(
      title: "Cashdown Payment",
      description:
          "Would you like to signify Cashdown Payment for this Loan Request?",
      cancelTitle: "No",
      confirmationTitle: "Yes",
    )
        .then((val) {
      ans = val.confirmed ? 'yes' : 'no';
      return cashDownPayment(
          reqData: {'loan_request_id': loanRequestId, 'cash_down': ans});
    }).then((val) {
      _dialogService.showDialog(
          title: 'Cashdown Payment',
          description: val
              ? "Cashdown request successful"
              : "Error with cashdown request");
      _navigationService.navigateAndClearRoute(AllRequestScreen.routeName);
    });
  }
}
