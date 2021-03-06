import 'package:flutter/foundation.dart';

class BankDetails {
  final int id;
  final String accountNo;
  final String accountName;
  final String bankCode;
  final String bankName;

  BankDetails({
    @required this.id,
    @required this.accountNo,
    @required this.accountName,
    this.bankCode,
    this.bankName
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_number': accountNo,
      'account_name': accountName,
      'bank_code': bankCode
    };
  }

  static BankDetails fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BankDetails(
        id: map['bank_id'] != null ? map['bank_id'] : map['id'],
        accountNo: map['account_number'].toString(),
        accountName: map['account_name'] != null ? map['account_name'] : "",
        bankCode: map['bank_code'],
        bankName: map['bank_name']
    );
  }
}
