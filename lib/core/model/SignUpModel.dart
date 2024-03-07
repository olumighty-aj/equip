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
    double? longitude,
    double? latitude,
    String? country,
    String? password,
  }) {
    _fullname = fullname;
    _country = country;
    _email = email;
    _phoneNumber = phoneNumber;
    _password = password;
    _postalCode = postalCode;
    _longitude = longitude;
    _latitude = latitude;
  }

  SignUpModel.fromJson(dynamic json) {
    _fullname = json['fullname'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _password = json['password'];
    _country = json["country"];
    _longitude = json["longitude"];
    _latitude = json["latitude"];
  }
  String? _fullname;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _country;
  String? _postalCode;
  double? _longitude;
  double? _latitude;
  SignUpModel copyWith({
    String? fullname,
    String? email,
    String? phoneNumber,
    String? password,
    String? postalCode,
    double? longitude,
    double? latitude,
  }) =>
      SignUpModel(
        fullname: fullname ?? _fullname,
        email: email ?? _email,
        phoneNumber: phoneNumber ?? _phoneNumber,
        password: password ?? _password,
        postalCode: postalCode ?? _postalCode,
        country: country ?? _country,
        longitude: longitude ?? _longitude,
        latitude: latitude ?? _latitude,
      );
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get password => _password;
  String? get country => _country;
  String? get postalCode => _postalCode;
  double? get longitude => _longitude;
  double? get latitude => _latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['postal_code'] = _postalCode;
    map['password'] = _password;
    map['country'] = _country;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    return map;
  }
}
