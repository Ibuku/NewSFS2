import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart';
import 'package:sfscredit/models/wallet_transaction.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/services/dialog_service.dart';
import 'package:sfscredit/services/navigation_service.dart';
import 'package:sfscredit/services/payment_service.dart';
import 'package:sfscredit/viewmodels/loan_application_view_model.dart';

import '../locator.dart';

class PaymentViewModel extends LoanApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PaymentService _payment = locator<PaymentService>();
  final ApplicationService _application = locator<ApplicationService>();

  String _reference;

  List<WalletTransaction> _walletTransactions = [];
  List<WalletTransaction> get walletTransactions => _walletTransactions;

  setWalletTransactions(List<WalletTransaction> transactions) {
    _walletTransactions = transactions;
    notifyListeners();
  }

  Future startAfreshCharge(String userEmail) async {
    Charge charge = Charge();
    charge.card = _getCardDefaults();

    setBusy(true);
    // Set transaction params directly in app (note that these params
    // are only used if an access_code is not set. In debug mode,
    // setting them after setting an access code would throw an exception
    _reference = await _payment.initializeAddCard();
    charge
      ..amount = (50 * 100) // In base currency
      ..email = userEmail
      ..reference = _reference
      ..putCustomField('Charged From', 'SFS Credits Mobile App');
    _chargeCard(charge);
  }

  Future startWalletCharge(Map reqData) async {
    setBusy(true);
    String reference = await _payment.initializeWalletTransaction(reqData);
    var paymentRes = await _payment.fundWallet({
      'reference': reference,
      'card_id': selectedCard.id.toString(),
      'card_last4': selectedCard.last4,
      'card_type': selectedCard.cardType,
      'amount': reqData['amount']
    });
    setBusy(false);

    if(paymentRes.runtimeType == Response){
      var body = jsonDecode(paymentRes.body);
      if(paymentRes.statusCode == 200){
        await confirmWalletCharge(reference);
      } else {
        _dialogService.showDialog(
          title: "Request Error",
          description: body['message']
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application Error",
        description: "An Error occured while making the transaction"
      );
    }
  }

  Future confirmWalletCharge(String reference) async {
    setBusy(true);
    var confirmTransactionRes = await _payment.confirmWalletTransaction(reference);
    setBusy(false);

    if(confirmTransactionRes.runtimeType == Response){
      var body = jsonDecode(confirmTransactionRes.body);
      if(confirmTransactionRes.statusCode == 200){
        _dialogService.showDialog(
            title: "Success",
            description: "Wallet Funded"
        );
        _navigationService.pop();
      } else {
        _dialogService.showDialog(
            title: "Request Error",
            description: body['message']
        );
      }
    } else {
      _dialogService.showDialog(
          title: "Application Error",
          description: "An Error occured while confirming the transaction"
      );
    }
  }

  Future withdrawFromWallet(Map reqData) async {
    setBusy(true);
    var withdrawalRes = await _payment.withdrawFromWallet(reqData);
    setBusy(false);

    if(withdrawalRes.runtimeType == Response){
      var body = jsonDecode(withdrawalRes.body);
      if(withdrawalRes.statusCode == 200){
        _dialogService.showDialog(
            title: "Success",
            description: "Withdrawal is being processed"
        );
        _navigationService.pop();
      } else {
        _dialogService.showDialog(
            title: "Request Error",
            description: body['message']
        );
      }
    } else {
      _dialogService.showDialog(
          title: "Application Error",
          description: "An Error occured while making the transaction"
      );
    }
  }

  _chargeCard(Charge charge) {
    // This is called only before requesting OTP
    // Save reference so you may send to server if error occurs with OTP
    handleBeforeValidate(Transaction transaction) {}

    handleOnError(Object e, Transaction transaction) async {
      // If an access code has expired, simply ask your server for a new one
      // and restart the charge instead of displaying error
      if (e is ExpiredAccessCodeException) {
        _chargeCard(charge);
        return;
      }

      if (e is CardException) {
        setBusy(false);
        return;
      }

      if (transaction.reference != null) {
        await _payment.verifyOnServer(transaction.reference);
      } else {
        setBusy(false);
      }
    }

    // This is called only after transaction is successful
    handleOnSuccess(Transaction transaction) async {
      var verifyRes = await _payment.verifyOnServer(transaction.reference);
      if (verifyRes.runtimeType == Response && verifyRes.statusCode == 200) {
        await getUsersCards();
        setBusy(false);
      }
    }

    PaystackPlugin.chargeCard(context,
        charge: charge,
        beforeValidate: (transaction) => handleBeforeValidate(transaction),
        onSuccess: (transaction) => handleOnSuccess(transaction),
        onError: (error, transaction) => handleOnError(error, transaction));
  }

  PaymentCard _getCardDefaults() {
    // Using just the must-required parameters.
    return PaymentCard(
      expiryYear: 0,
    );
  }

  void updateStatus(String reference, String message) {
    _dialogService.showDialog(
        title: 'Update Status',
        description: 'Reference: $reference \n\ Response: $message');
  }

  Future<void> getWalletTransactions() async {
    setBusy(true);

    var walletTransactionsRes = await _application.getWalletTransactions();

    setBusy(false);

    if (walletTransactionsRes.runtimeType == Response) {
      var body = jsonDecode(walletTransactionsRes.body);
      if (walletTransactionsRes.statusCode == 200) {
        List rawTransactions = body['data'];
        List<WalletTransaction> transactions = rawTransactions
            .map((transaction) => WalletTransaction.fromMap(transaction))
            .toList();
        setWalletTransactions(transactions);
      } else {
        _dialogService.showDialog(
          title: "Request error occured",
          description: body['message'],
        );
      }
    } else {
      _dialogService.showDialog(
        title: "Application error",
        description: walletTransactionsRes.toString(),
      );
    }
  }

  Future initWallet() async {
    setLoading(true);

    await Future.wait([getWalletBalance(), getWalletTransactions()]);

    setLoading(false);
  }


}
