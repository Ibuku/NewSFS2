import 'package:flutter/foundation.dart';

class UserCard {
  final int id;
  final String last4;
  final String cardType;
  final String display;

  UserCard({
    @required this.id,
    @required this.last4,
    @required this.cardType,
    this.display
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'last4': last4,
      'card_type': cardType
    };
  }

  static UserCard fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserCard(
        id: map['id'],
        last4: map['last4'],
        cardType: map['card_type'],
        display: "${map['card_type'].toUpperCase()}-${map['last4']}"
    );
  }
}
