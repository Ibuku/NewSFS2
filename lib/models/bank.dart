import 'package:flutter/foundation.dart';

class Bank {
  final int id;
  final String name;
  final String code;
  final String country;
  final String currency;
  final String display;

  Bank({
    @required this.id,
    @required this.name,
    @required this.code,
    @required this.country,
    @required this.currency,
    this.display
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'country': country,
      'currency': currency
    };
  }

  static Bank fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return Bank(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      country: map['country'],
      currency: map['currency'],
      display: map['name']
    );
  }
}
