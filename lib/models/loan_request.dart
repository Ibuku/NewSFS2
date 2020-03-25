import 'package:flutter/foundation.dart';
import 'package:sfscredit/models/loan_package.dart';

class LoanRequest {
  final String id;
  final int userId;
  final int currentSalary;
  final String description;
  final String status;
  final String approvalDate;
  final LoanPackage loanPackage;
  final String createdAt;

  LoanRequest({
    @required this.id,
    @required this.userId,
    @required this.currentSalary,
    this.description,
    @required this.status,
    this.approvalDate,
    @required this.loanPackage,
    @required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'current_salary': currentSalary,
      'description': description,
      'status': status,
      'approval_date': approvalDate,
      'created_at': createdAt,
      'loan_package': loanPackage.toMap()
    };
  }

  static LoanRequest fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return LoanRequest (
        id: map['id'],
        userId: map['user_id'],
        currentSalary: map['current_salary'],
        description: map['description'],
        status: map['status'],
        approvalDate: map['approval_date'],
        createdAt: map['created_at'],
        loanPackage: LoanPackage.fromMap(map['loan_package'])
    );
  }
}
