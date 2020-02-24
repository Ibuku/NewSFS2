import 'package:flutter/foundation.dart';

class Company {
  final int id;
  final String logo;
  final String emailDomain;
  final int industryID;
  final String name;
  final String display;

  Company({
    @required this.id,
    @required this.name,
    @required this.emailDomain,
    this.industryID,
    this.logo,
    this.display
  });

  Map<String, dynamic> toMap() {
    return {
      'email_domain': emailDomain,
      'id': id,
      'logo': logo,
      'name': name,
      'industry_id': industryID,
    };
  }

  static Company fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return Company(
      id: map['id'],
      logo: map['logo'],
      emailDomain: map['email_domain'],
      name: map['name'],
      industryID: map['industry_id'],
      display: map['name'],
    );
  }
}
