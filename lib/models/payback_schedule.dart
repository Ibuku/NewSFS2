import 'package:flutter/foundation.dart';

class PaybackSchedule {
  final int id;
  final String loanRequestId;
  final String paymentStatus;
  final int amountDue;
  final String paybackDate;
  final String extendedPaybackDate;

  PaybackSchedule({
    @required this.id,
    @required this.loanRequestId,
    @required this.paymentStatus,
    @required this.amountDue,
    @required this.paybackDate,
    this.extendedPaybackDate
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loan_request_id': loanRequestId,
      'payment_status': paymentStatus,
      'amount_due': amountDue,
      'payback_date': paybackDate,
      'extended_payback_date': extendedPaybackDate
    };
  }

  static PaybackSchedule fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return PaybackSchedule (
        id: map['id'],
        loanRequestId: map['loan_request_id'],
        paymentStatus: map['payment_status'],
        amountDue: map['amount_due'],
        paybackDate: map['payback_date'],
        extendedPaybackDate: map['extended_payback_date']
    );
  }
}
