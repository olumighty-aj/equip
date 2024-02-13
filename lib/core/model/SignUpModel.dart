/// fullname : "Oluwaseun Alatise"
/// email : "holynation667@gmail.com"
/// phone_number : "+2348109994486"
/// password : "_12345678"

class SignUpModel {
  SignUpModel({
    String? fullname,
    String? email,
    String? phoneNumber,
    String? postalCode,
    String? password,
  }) {
    _fullname = fullname;
    _email = email;
    _phoneNumber = phoneNumber;
    _password = password;
  }

  SignUpModel.fromJson(dynamic json) {
    _fullname = json['fullname'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _password = json['password'];
  }
  String? _fullname;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _postalCode;
  SignUpModel copyWith({
    String? fullname,
    String? email,
    String? phoneNumber,
    String? password,
    String? postalCode,
  }) =>
      SignUpModel(
        fullname: fullname ?? _fullname,
        email: email ?? _email,
        phoneNumber: phoneNumber ?? _phoneNumber,
        password: password ?? _password,
        postalCode: postalCode ?? _postalCode,
      );
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['password'] = _password;
    return map;
  }
}
