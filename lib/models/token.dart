class Token {
  String accessToken;
  String expiresAt;

  Token({this.accessToken, this.expiresAt});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_at'] = this.expiresAt;
    return data;
  }
}
