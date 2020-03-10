class UserProfile {
  int userId;
  String avatar;
  String phoneNumber;
  String bvn;
  String nextOfKin;
  String dateOfBirth;

  UserProfile({
    this.userId,
    this.avatar,
    this.phoneNumber,
    this.bvn,
    this.nextOfKin,
    this.dateOfBirth,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    avatar = json['avatar'];
    phoneNumber = json['phone_number'];
    bvn = json['bvn'];
    nextOfKin = json['next_of_kin'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    data['phone_number'] = this.phoneNumber;
    data['bvn'] = this.bvn;
    data['next_of_kin'] = this.nextOfKin;
    data['date_of_birth'] = this.dateOfBirth;
    return data;
  }
}
