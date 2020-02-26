class User {
  int id;
  String firstname;
  String lastname;
  String email;
  int companyId;
  String fullName;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.companyId,
    this.fullName,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    companyId = json['company_id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['company_id'] = this.companyId;
    data['full_name'] = this.fullName;
    return data;
  }
}
