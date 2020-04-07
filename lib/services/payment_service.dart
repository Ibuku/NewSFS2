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
      return _network.post('$API_BASE_URL/card-authorization',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: {'ref_code': reference},
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future initializeAddCard() async {
    try {
      Response res = await _network.post('$API_BASE_URL/cards/initialize',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
      var body = jsonDecode(res.body);
      return body['data']['reference'];
    } catch (e) {
      return e;
    }
  }

  Future withdrawFromWallet(Map reqData) async {
    try {
      Response res = await _network.post('$API_BASE_URL/wallet/transfer/bank',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: reqData,
          encodeBody: false,
          isAuth: true);
      var body = jsonDecode(res.body);
      print("$body");
    } catch (e) {
      return e;
    }
  }

  Future initializeWalletTransaction(int amount) async {
    try {
      Response res = await _network.post('$API_BASE_URL/wallet/fund/initialize',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {'amount': amount},
          encodeBody: false,
          isAuth: true);
      var body = jsonDecode(res.body);
      return body['data']['reference'];
    } catch (e) {
      return e;
    }
  }

  Future fundWallet(Map reqData) async {
    try {
      Response res = await _network.post("$API_BASE_URL/wallet/fund/pay",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: reqData,
          encodeBody: false,
          isAuth: true);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future confirmWalletTransaction(String reference) async {
    try {
      Response res = await _network.post('$API_BASE_URL/wallet/fund/confirm',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {'reference': reference},
          encodeBody: false,
          isAuth: true);
      return res;
    } catch (e) {
      return e;
    }
  }
}
