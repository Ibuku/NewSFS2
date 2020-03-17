import 'package:flutter/foundation.dart';

class Loan {
  final String id;
  final int userId;
  final int packageId;
  final String guarantorEmail;
  final int totalPayback;
  final String status;

  Loan({
    @required this.id,
    @required this.userId,
    @required this.packageId,
    @required this.guarantorEmail,
    @required this.totalPayback,
    @required this.status
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'loan_package_id': packageId,
      'guarantor_email': guarantorEmail,
      'total_payback': totalPayback,
      'status': status
    };
  }

  static Loan fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return Loan (
      id: map['id'],
      userId: map['user_id'],
      packageId: map['loan_package_id'],
      guarantorEmail: map['guarantor_email'],
      totalPayback: map['loan_package']['total_payback'],
      status: map['status']
    );
  }
}
