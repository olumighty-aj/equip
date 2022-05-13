/// email : "holynation667@gmail.com"
/// password : "_12345678"
/// fcm_token : "uni75y6n45df6"

class LoginPayload {
  LoginPayload({
      String? email, 
      String? password, 
      String? fcmToken,}){
    _email = email;
    _password = password;
    _fcmToken = fcmToken;
}

  LoginPayload.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _fcmToken = json['fcm_token'];
  }
  String? _email;
  String? _password;
  String? _fcmToken;
LoginPayload copyWith({  String? email,
  String? password,
  String? fcmToken,
}) => LoginPayload(  email: email ?? _email,
  password: password ?? _password,
  fcmToken: fcmToken ?? _fcmToken,
);
  String? get email => _email;
  String? get password => _password;
  String? get fcmToken => _fcmToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    map['fcm_token'] = _fcmToken;
    return map;
  }

}