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
      var body = jsonDecode(guarantorRequestRes.body);
      if (guarantorRequestRes.statusCode == 200) {
        if (!body['data'].isEmpty) {
          List rawRequests = body['data'];
          List<GuarantorRequest> requests =
              rawRequests.map((i) => GuarantorRequest.fromMap((i))).toList();
          setGuarantorRequests(requests);
        }
      } else {
        _dialogService.showDialog(
          title: "Request error occured",
          description: body['message'] ?? "Service Unavailable",
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
      if (modifyGuarantorRequestRes.statusCode == 200) {
        _dialogService.showDialog(
            title: "Guarantor Request", description: body['message']);
        _navigationService.navigateAndClearRoute(AllRequestScreen.routeName);
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

  Future<bool> addGuarantorBankDetails({@required Map reqData}) async {
    setBusy(true);
    var addGuarantorDetailsRes =
        await _application.addGuarantorBankDetails(reqData: reqData);
    if (addGuarantorDetailsRes.runtimeType == Response) {
      var body = jsonDecode(addGuarantorDetailsRes.body);
      if (addGuarantorDetailsRes.statusCode == 200) {
        return true;
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
    return false;
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
        _dialogService.showDialog(
            title: 'Cashdown Request Error', description: body['message'] ?? 'Service Unavailable');
      }
    } else {
      print("Error: ${cashDownRes.toString()}");
      _dialogService.showDialog(
          title: 'Application Error',
          description: "Failed to make Cashdown request");
    }
    return false;
  }
}
