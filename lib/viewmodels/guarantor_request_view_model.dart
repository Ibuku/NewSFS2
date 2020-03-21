import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sfscredit/models/guarantor_request.dart';

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

  void setGuarantorRequests(List<GuarantorRequest> requests){
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
    if(guarantorRequestRes.runtimeType == Response) {
      if (guarantorRequestRes.statusCode == 200) {
        var body = jsonDecode(guarantorRequestRes.body);
        if(!body['data'].isEmpty) {
          List rawRequests = body['data'];
          List<GuarantorRequest> requests = rawRequests.map((i) => GuarantorRequest.fromMap((i))).toList();
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

  Future<void> initReq() async {
    setLoading(true);

    await getGuarantorRequests();

    setLoading(false);
  }
}
