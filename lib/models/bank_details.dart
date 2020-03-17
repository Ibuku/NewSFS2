import 'package:flutter/foundation.dart';

class BankDetails {
  final int id;
  final int accountNo;
  final String accountName;
  final String bankCode;

  BankDetails({
    @required this.id,
    @required this.accountNo,
    @required this.accountName,
    @required this.bankCode
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_no': accountNo,
      'account_name': accountName,
      'bank_code': bankCode
    };
  }

  static BankDetails fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BankDetails(
        id: map['id'],
        accountNo: map['account_no'],
        accountName: map['account_name'],
        bankCode: map['bank_code']
    );
  }
}
