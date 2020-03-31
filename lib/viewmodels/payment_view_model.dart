import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:sfscredit/services/dialog_service.dart';
import 'package:sfscredit/services/payment_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/viewmodels/loan_application_view_model.dart';

import '../locator.dart';

class PaymentViewModel extends LoanApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final PaymentService _payment = locator<PaymentService>();

  String _reference;
  BuildContext _context;

  Future startAfreshCharge(String userEmail) async {
    Charge charge = Charge();
    charge.card = _getCardDefaults();

    setBusy(true);
    // Set transaction params directly in app (note that these params
    // are only used if an access_code is not set. In debug mode,
    // setting them after setting an access code would throw an exception
    _reference = await _payment.fetchReferenceFromServer();
    charge
      ..amount = (50 * 100) // In base currency
      ..email = userEmail
      ..reference = _reference
      ..putCustomField('Charged From', 'Flutter SDK');
    _chargeCard(charge);
  }

  _chargeCard(Charge charge) {
    // This is called only before requesting OTP
    // Save reference so you may send to server if error occurs with OTP
    handleBeforeValidate(Transaction transaction) {
      updateStatus(transaction.reference, 'validating...');
    }

    handleOnError(Object e, Transaction transaction) async {
      // If an access code has expired, simply ask your server for a new one
      // and restart the charge instead of displaying error
      if (e is ExpiredAccessCodeException) {
        _chargeCard(charge);
        return;
      }

      if (transaction.reference != null) {
        await _payment.verifyOnServer(transaction.reference);
      } else {
        setBusy(false);
        updateStatus(transaction.reference, e.toString());
      }
    }

    // This is called only after transaction is successful
    handleOnSuccess(Transaction transaction) async {
      var verifyRes = await _payment.verifyOnServer(transaction.reference);
      if(verifyRes.runtimeType == Response && verifyRes.statusCode == 200){
        setBusy(false);
      }
    }

    PaystackPlugin.chargeCard(_context,
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
      description: 'Reference: $reference \n\ Response: $message'
    );
  }

  void setBuildContext(BuildContext context){
    _context = context;
  }
}
