/// token : "eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJJRCI6IjEyIiwiZnVsbG5hbWUiOiJIb2x5bmF0aW9uIGRldmVsb3BlciIsImVtYWlsIjoiaG9seW5hdGlvbjY2N0BnbWFpbC5jb20iLCJwaG9uZV9udW1iZXIiOiIrMjM0ODEwOTk5NDQ4NiIsImdlbmRlciI6IiIsImFkZHJlc3MiOiJObyAyNiwgR2JlbWlzb2xhIHN0cmVldCwgQWxsZW4gQXZlbnVlLCBJa2VqYSIsImFkZHJlc3Nfb3B0IjpudWxsLCJsb2NhbF9zdGF0ZSI6bnVsbCwiY291bnRyeSI6Ik5pZ2VyaWEiLCJsYXRpdHVkZSI6bnVsbCwibG9uZ2l0dWRlIjpudWxsLCJoaXJlcnNfcGF0aCI6bnVsbCwic3RhdHVzIjoiMSIsImRhdGVfbW9kaWZpZWQiOiIyMDIyLTA2LTAzIDE0OjE0OjU0IiwiZGF0ZV9jcmVhdGVkIjoiMjAyMi0wNS0wNiAxMjo0NTo0NCIsInVzZXJuYW1lIjoiaG9seW5hdGlvbjY2N0BnbWFpbC5jb20iLCJ1c2VyX3R5cGUiOiJoaXJlcnMiLCJ1c2VyX3RhYmxlX2lkIjoiOSIsImxhc3RfbG9naW4iOiIyMDIyLTA1LTEwIDE2OjQ5OjM2IiwiYWN0aXZpdHlfbG9nIjoiMSIsImZjbV90b2tlbiI6InVuaTc1eTZuNDVkZjYiLCJsYXN0X2xvZ291dCI6bnVsbCwibGFzdF9jaGFuZ2VfcGFzc3dvcmQiOiIyMDIyLTA1LTA2IDEyOjQ1OjQ0In0.jiFgQMONZfqjNTiDT-bOB4_MsvSEpJoUAzJQ5_kgzmk"
/// details : {"ID":"9","fullname":"Holynation developer","email":"holynation667@gmail.com","phone_number":"+2348109994486","gender":"","address":"No 26, Gbemisola street, Allen Avenue, Ikeja","address_opt":null,"local_state":null,"country":"Nigeria","latitude":null,"longitude":null,"hirers_path":null,"status":"1","date_modified":"2022-06-03 14:14:54","date_created":"2022-05-06 12:45:44","username":"holynation667@gmail.com","user_type":"hirers","last_login":"2022-05-10 16:49:36","activity_log":"1","fcm_token":"uni75y6n45df6","last_logout":null,"last_change_password":"2022-05-06 12:45:44","kyc_updated":false,"kyc_approved":false}

class SignInResponse {
  SignInResponse({
    String? token,
    Details? details,
  }) {
    _token = token;
    _details = details;
  }

  SignInResponse.fromJson(dynamic json) {
    _token = json['token'];
    _details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? _token;
  Details? _details;
  SignInResponse copyWith({
    String? token,
    Details? details,
  }) =>
      SignInResponse(
        token: token ?? _token,
        details: details ?? _details,
      );
  String? get token => _token;
  Details? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    return map;
  }
}

/// ID : "9"
/// fullname : "Holynation developer"
/// email : "holynation667@gmail.com"
/// phone_number : "+2348109994486"
/// gender : ""
/// address : "No 26, Gbemisola street, Allen Avenue, Ikeja"
/// address_opt : null
/// local_state : null
/// country : "Nigeria"
/// latitude : null
/// longitude : null
/// hirers_path : null
/// status : "1"
/// date_modified : "2022-06-03 14:14:54"
/// date_created : "2022-05-06 12:45:44"
/// username : "holynation667@gmail.com"
/// user_type : "hirers"
/// last_login : "2022-05-10 16:49:36"
/// activity_log : "1"
/// fcm_token : "uni75y6n45df6"
/// last_logout : null
/// last_change_password : "2022-05-06 12:45:44"
/// kyc_updated : false
/// kyc_approved : false

class Details {
  Details({
    String? id,
    String? fullname,
    String? email,
    String? phoneNumber,
    String? gender,
    String? address,
    dynamic addressOpt,
    dynamic localState,
    String? country,
    dynamic latitude,
    dynamic longitude,
    dynamic hirersPath,
    String? status,
    String? dateModified,
    String? dateCreated,
    String? username,
    String? userType,
    String? lastLogin,
    String? activityLog,
    String? fcmToken,
    dynamic lastLogout,
    String? lastChangePassword,
    bool? kycUpdated,
    String? kycApproved,
    String? becomeOwner,
    String? isOwner,
    String? postalCode,
  }) {
    _id = id;
    _postalCode = postalCode;
    _fullname = fullname;
    _email = email;
    _phoneNumber = phoneNumber;
    _gender = gender;
    _address = address;
    _addressOpt = addressOpt;
    _localState = localState;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _hirersPath = hirersPath;
    _status = status;
    _dateModified = dateModified;
    _become_owner = becomeOwner;
    _dateCreated = dateCreated;
    _username = username;
    _userType = userType;
    _lastLogin = lastLogin;
    _activityLog = activityLog;
    _fcmToken = fcmToken;
    _lastLogout = lastLogout;
    _lastChangePassword = lastChangePassword;
    _kycUpdated = kycUpdated;
    _kycApproved = kycApproved;
    _isOwner = isOwner;
  }

  Details.fromJson(dynamic json) {
    _id = json['ID'];
    _postalCode = json["postal_code"];
    _fullname = json['fullname'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _gender = json['gender'];
    _address = json['address'];
    _addressOpt = json['address_opt'];
    _localState = json['local_state'];
    _country = json['country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _hirersPath = json['hirers_path'];
    _become_owner = json["become_owner"];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
    _username = json['username'];
    _userType = json['user_type'];
    _lastLogin = json['last_login'];
    _activityLog = json['activity_log'];
    _fcmToken = json['fcm_token'];
    _lastLogout = json['last_logout'];
    _lastChangePassword = json['last_change_password'];
    _kycUpdated = json['kyc_updated'];
    _kycApproved = json['kyc_approved'];
    _isOwner = json["is_owners"];
  }
  String? _id;
  String? _fullname;
  String? _email;
  String? _postalCode;
  String? _phoneNumber;
  String? _gender;
  String? _address;
  dynamic _addressOpt;
  String? _become_owner;
  dynamic _localState;
  String? _country;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _hirersPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
  String? _username;
  String? _userType;
  String? _lastLogin;
  String? _activityLog;
  String? _fcmToken;
  dynamic _lastLogout;
  String? _lastChangePassword;
  String? _isOwner;
  bool? _kycUpdated;
  String? _kycApproved;
  Details copyWith({
    String? id,
    String? postalCode,
    String? fullname,
    String? email,
    String? phoneNumber,
    String? gender,
    String? address,
    dynamic addressOpt,
    dynamic localState,
    String? country,
    dynamic latitude,
    dynamic longitude,
    dynamic hirersPath,
    String? becomeOwner,
    String? status,
    String? dateModified,
    String? dateCreated,
    String? username,
    String? userType,
    String? lastLogin,
    String? activityLog,
    String? isOwner,
    String? fcmToken,
    dynamic lastLogout,
    String? lastChangePassword,
    bool? kycUpdated,
    String? kycApproved,
  }) =>
      Details(
        id: id ?? _id,
        postalCode: postalCode ?? _postalCode,
        fullname: fullname ?? _fullname,
        email: email ?? _email,
        phoneNumber: phoneNumber ?? _phoneNumber,
        gender: gender ?? _gender,
        address: address ?? _address,
        addressOpt: addressOpt ?? _addressOpt,
        localState: localState ?? _localState,
        country: country ?? _country,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        hirersPath: hirersPath ?? _hirersPath,
        status: status ?? _status,
        dateModified: dateModified ?? _dateModified,
        dateCreated: dateCreated ?? _dateCreated,
        username: username ?? _username,
        becomeOwner: becomeOwner ?? _become_owner,
        userType: userType ?? _userType,
        lastLogin: lastLogin ?? _lastLogin,
        activityLog: activityLog ?? _activityLog,
        fcmToken: fcmToken ?? _fcmToken,
        lastLogout: lastLogout ?? _lastLogout,
        lastChangePassword: lastChangePassword ?? _lastChangePassword,
        kycUpdated: kycUpdated ?? _kycUpdated,
        kycApproved: kycApproved ?? _kycApproved,
        isOwner: isOwner ?? _isOwner,
      );
  String? get id => _id;
  String? get postalCode => _postalCode;
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get gender => _gender;
  String? get becomeOwner => _become_owner;
  String? get address => _address;
  dynamic get addressOpt => _addressOpt;
  dynamic get localState => _localState;
  String? get country => _country;
  dynamic get latitude => _latitude;
  dynamic get isOwner => _isOwner;
  dynamic get longitude => _longitude;
  dynamic get hirersPath => _hirersPath;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;
  String? get username => _username;
  String? get userType => _userType;
  String? get lastLogin => _lastLogin;
  String? get activityLog => _activityLog;
  String? get fcmToken => _fcmToken;
  dynamic get lastLogout => _lastLogout;
  String? get lastChangePassword => _lastChangePassword;
  bool? get kycUpdated => _kycUpdated;
  String? get kycApproved => _kycApproved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map["postal_code"] = _postalCode;
    map['phone_number'] = _phoneNumber;
    map['gender'] = _gender;
    map['address'] = _address;
    map['address_opt'] = _addressOpt;
    map['local_state'] = _localState;
    map['country'] = _country;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['hirers_path'] = _hirersPath;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    map['username'] = _username;
    map['user_type'] = _userType;
    map['last_login'] = _lastLogin;
    map['activity_log'] = _activityLog;
    map['fcm_token'] = _fcmToken;
    map['last_logout'] = _lastLogout;
    map['last_change_password'] = _lastChangePassword;
    map['kyc_updated'] = _kycUpdated;
    map['kyc_approved'] = _kycApproved;
    return map;
  }
}
