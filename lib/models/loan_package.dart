import 'package:flutter/foundation.dart';

class LoanPackage {
  final int id;
  final String name;
  final int amount;
  final int interestRate;
  final int totalPayback;
  final int tenure;
  final String status;

  LoanPackage({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.interestRate,
    @required this.totalPayback,
    @required this.tenure,
    @required this.status
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'interest_rate': interestRate,
      'total_payback': totalPayback,
      'tenure': tenure,
      'status': status
    };
  }

  static LoanPackage fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return LoanPackage (
        id: map['id'],
        name: map['name'],
        amount: map['amount'],
        interestRate: map['interest_rate'],
        totalPayback: map['total_payback'],
        tenure: map['tenure'],
        status: map['status']
    );
  }
}
