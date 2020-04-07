import 'package:flutter/foundation.dart';

class WalletTransaction {
  final int id;
  final int walletId;
  final int amount;
  final String type;
  final String createdAt;

  WalletTransaction({
    @required this.id,
    @required this.walletId,
    @required this.amount,
    @required this.type,
    @required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wallet_id': walletId,
      'amount': amount,
      'type': type,
      'created_at': createdAt
    };
  }

  static WalletTransaction fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return WalletTransaction (
        id: map['id'],
        walletId: map['wallet_id'],
        amount: map['amount'],
        type: map['type'],
        createdAt: map['created_at']
    );
  }
}
