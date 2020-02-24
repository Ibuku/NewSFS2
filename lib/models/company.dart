import 'package:flutter/foundation.dart';

class Company {
  final String id;
  final String logo;
  final String emailDomain;
  final String industryID;
  final String name;

  Company({
    @required this.id,
    @required this.name,
    @required this.emailDomain,
    this.industryID,
    this.logo,
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
    );
  }
}
