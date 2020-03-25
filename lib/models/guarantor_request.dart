import 'package:flutter/foundation.dart';

import 'loan_request.dart';

class GuarantorRequest {
  final int id;
  final String loanRequestId;
  final int guarantorSalary;
  final String guarantorBankStatement;
  final String guarantorApproved;
  final LoanRequest loanRequest;
  final String createdAt;

  GuarantorRequest({
    @required this.id,
    @required this.loanRequestId,
    this.guarantorSalary,
    this.guarantorBankStatement,
    @required this.guarantorApproved,
    @required this.loanRequest,
    @required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loan_request_id': loanRequestId,
      'guarantor_salary': guarantorSalary,
      'guarantor_bank_statement': guarantorBankStatement,
      'guarantor_approved': guarantorApproved,
      'created_at': createdAt,
      'loan_request': loanRequest.toMap(),
    };
  }

  static GuarantorRequest fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return GuarantorRequest (
        id: map['id'],
        loanRequestId: map['loan_request_id'],
        guarantorSalary: map['guarantor_salary'],
        guarantorBankStatement: map['guarantor_bank_statement'],
        guarantorApproved: map['guarantor_approved'],
        loanRequest: LoanRequest.fromMap(map['loan_request'])
    );
  }
}
