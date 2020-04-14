import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:sfscredit/const.dart';
import 'package:sfscredit/locator.dart';
import 'local_storage_service.dart';
import 'network_service.dart';
import 'token_service.dart';

import '../models/user.dart';

class ApplicationService {
  final NetworkService _network = locator<NetworkService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final TokenService _tokenService = locator<TokenService>();

  static StreamController _user$;

  static User user = User(); // store the current authenticated user

  User get getUser => user;

  static Future<void> initialize() async {
    _user$ = StreamController<String>.broadcast();
  }

  Future<void> logout() async {
    await _localStorageService.empty();
  }

  void dispose() async {
    await logout();
    _user$.close();
  }

  Future userProfile() async {
    try {
      final res = await _network.get(
        "$API_BASE_URL/user",
        isAuth: true,
        headers: {
          "Accept": "application/json",
        },
      );
      return res;
    } catch (e) {
      return e;
    }
  }

  Future updateUserProfile(Map body) async {
    try {
      var updateResult =
          await _network.post("$API_BASE_URL/user/update-profile",
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
              },
              body: body,
              encodeBody: false,
              isAuth: true);
      return updateResult;
    } catch (e) {
      return e;
    }
  }

  Future getLoanRequests() async {
    try {
      return await _network.get("$API_BASE_URL/loan-requests",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getWallet() async {
    try {
      return await _network.get("$API_BASE_URL/wallet",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getGuarantorRequests() async {
    try {
      return await _network.get("$API_BASE_URL/guarantor-requests",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getApprovedLoanPackages() async {
    try {
      return await _network.get("$API_BASE_URL/loan-packages?status=approved",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getBanks() async {
    try {
      return await _network.get("https://api.paystack.co/bank", headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });
    } catch (e) {
      return e;
    }
  }

  Future getUsersBankDetails() async {
    try {
      return await _network.get("$API_BASE_URL/bank",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getUsersCards() async {
    try {
      return await _network.get("$API_BASE_URL/cards",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future addBankDetails(Map reqData) async {
    try {
      return await _network.post("$API_BASE_URL/bank",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: reqData,
          encodeBody: false,
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future resolveBankDetails(String accountNo, String bankCode) async {
    try {
      return await _network.get(
          "$API_BASE_URL/user/bank_details/resolve?account_number=$accountNo&bank_code=$bankCode",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future requestForALoan({@required loanReqData}) async {
    try {
      var reqResult = await _network.post("$API_BASE_URL/loan-request/new",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: loanReqData,
          encodeBody: false,
          isAuth: true);
      return reqResult;
    } catch (e) {
      return e;
    }
  }

  Future approveOrDeclineLoanRequest(
      {@required reqData, @required action}) async {
    try {
      if (action != 'approve' && action != 'declined') {
        return;
      }
      var reqResult =
          await _network.post("$API_BASE_URL/guarantor-request/$action/loan",
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
              },
              body: reqData,
              encodeBody: false,
              isAuth: true);
      return reqResult;
    } catch (e) {
      return e;
    }
  }

  Future getPaybackSchedules() async {
    try {
      return await _network.get("$API_BASE_URL/loan-request/payback-schedules",
          headers: {"Accept": "application/json"}, isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future addGuarantorBankDetails({@required reqData}) async {
    try {
      return await _network.post(
          "$API_BASE_URL/guarantor-request/loan-request/bankDetails",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: reqData,
          encodeBody: false,
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getWalletTransactions() async {
    try {
      return await _network.get("$API_BASE_URL/wallet/transactions",
          headers: {"Accept": "application/json"}, isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future uploadFile(Map reqData) async {
    try {
      return await _network.postFile("$API_BASE_URL/file/upload",
          body: reqData);
    } catch (e) {
      return e;
    }
  }

  Future uploadFile2(dynamic reqData) async {
    try {
      var dio = Dio();
      FormData formData = FormData.fromMap(reqData);
      return await dio.post("$API_BASE_URL/file/upload", data: formData);
    } catch (e) {
      return e;
    }
  }

  Future uploadUserAvatar(Map reqData) async {
    try {
      return await _network.post("$API_BASE_URL/user/avatar",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: reqData,
          encodeBody: false,
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future cashDownPayment(Map reqData) async {
    try {
      return await _network.post(
          "$API_BASE_URL/guarantor-request/loan-request/cash-down",
          body: reqData,
          encodeBody: false,
          isAuth: true);
    } catch (e) {
      return e;
    }
  }

  Future getNotifications() async {
    try {
      return await _network.get("$API_BASE_URL/notifications",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          isAuth: true);
    } catch (e) {
      return e;
    }
  }
}
