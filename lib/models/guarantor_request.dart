import 'package:flutter/foundation.dart';

class GuarantorRequest {
  final int id;
  final String loanRequestId;
  final int guarantorSalary;
  final String guarantorBankStatement;
  final String guarantorApproved;
  final int loanAmount;
  final String loanStatus;
  final String createdAt;

  GuarantorRequest({
    @required this.id,
    @required this.loanRequestId,
    this.guarantorSalary,
    this.guarantorBankStatement,
    @required this.guarantorApproved,
    @required this.loanAmount,
    @required this.loanStatus,
    @required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loan_request_id': loanRequestId,
      'guarantor_salary': guarantorSalary,
      'guarantor_bank_statement': guarantorBankStatement,
      'guarantor_approved': guarantorApproved,
      'loan_amount': loanAmount,
      'loan_status': loanStatus,
      'created_at': createdAt
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
        loanAmount: map['loan_request']['loan_package']['total_payback'],
        loanStatus: map['loan_request']['status'],
        createdAt: map['loan_request']['created_at']
    );
  }
}
