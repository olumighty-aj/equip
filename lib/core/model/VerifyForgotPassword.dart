/// email : "holynationdevelopment@gmail.com"
/// otp : "633999"
/// password : "Jesus_12345678"

class VerifyForgotPassword {
  VerifyForgotPassword({
      String? email, 
      String? otp, 
      String? password,}){
    _email = email;
    _otp = otp;
    _password = password;
}

  VerifyForgotPassword.fromJson(dynamic json) {
    _email = json['email'];
    _otp = json['otp'];
    _password = json['password'];
  }
  String? _email;
  String? _otp;
  String? _password;
VerifyForgotPassword copyWith({  String? email,
  String? otp,
  String? password,
}) => VerifyForgotPassword(  email: email ?? _email,
  otp: otp ?? _otp,
  password: password ?? _password,
);
  String? get email => _email;
  String? get otp => _otp;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['otp'] = _otp;
    map['password'] = _password;
    return map;
  }

}