import 'package:sfscredit/models/user_profile.dart';

class User {
  int id;
  String firstname;
  String lastname;
  String email;
  int companyId;
  String fullName;
  UserProfile profile;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.companyId,
    this.fullName,
    this.profile,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    companyId = json['company_id'];
    fullName = json['full_name'];
    profile = json['user_profile'] == null
        ? null
        : UserProfile.fromJson(json['user_profile']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['company_id'] = this.companyId;
    data['full_name'] = this.fullName;
    data['profile'] = this.profile;
    return data;
  }
}