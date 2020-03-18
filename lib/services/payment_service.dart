import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:sfscredit/const.dart';
import 'package:sfscredit/locator.dart';
import 'network_service.dart';

class PaymentService {
  final NetworkService _network = locator<NetworkService>();

  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $PAYSTACK_PUBLIC_KEY"
  };

  Future verifyOnServer(String reference) async {
    try {
      return _network.get('$BASE_URL/verify/$reference', headers: headers);
    } catch (e) {
      return e;
    }
  }

  Future<String> fetchAccessCodeFromServer() async {
    try {
      Response res = await _network.get('$API_BASE_URL/cards/initialize', headers: headers);
      var body = jsonDecode(res.body);
      return body['data']['ref_code'];
    } catch (e) {
      return e;
    }
  }
}