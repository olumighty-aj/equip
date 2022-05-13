/// token : "eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJJRCI6IjExIiwiZnVsbG5hbWUiOiJPbHV3YXNldW4gQWxhdGlzZSIsImVtYWlsIjoiaG9seW5hdGlvbmRldmVsb3BtZW50QGdtYWlsLmNvbSIsInBob25lX251bWJlciI6IisyMzQ4MTA5OTk0NDg1IiwiZ2VuZGVyIjoiIiwiYWRkcmVzcyI6bnVsbCwiYWRkcmVzc19vcHQiOm51bGwsImxvY2FsX3N0YXRlIjpudWxsLCJjb3VudHJ5IjpudWxsLCJoaXJlcnNfcGF0aCI6bnVsbCwic3RhdHVzIjoiMSIsImRhdGVfbW9kaWZpZWQiOiIyMDIyLTA1LTAzIDExOjM3OjA2IiwiZGF0ZV9jcmVhdGVkIjoiMjAyMi0wNS0wMyAxMTozNzowNiIsInVzZXJuYW1lIjoiaG9seW5hdGlvbmRldmVsb3BtZW50QGdtYWlsLmNvbSIsInVzZXJfdHlwZSI6ImhpcmVycyIsInVzZXJfdGFibGVfaWQiOiI4IiwibGFzdF9sb2dpbiI6IjIwMjItMDUtMDMgMTM6NDc6MTMiLCJhY3Rpdml0eV9sb2ciOiIxIiwiZmNtX3Rva2VuIjoidW5pNzV5Nm5mZGlmbjkiLCJsYXN0X2xvZ291dCI6bnVsbCwibGFzdF9jaGFuZ2VfcGFzc3dvcmQiOiIyMDIyLTA1LTAzIDEzOjQ3OjEzIn0.37RLz_ozkjz7q9d59BUdUPlka7IpQ55g4dZZT_uDkHo"
/// details : {"ID":"11","fullname":"Oluwaseun Alatise","email":"holynationdevelopment@gmail.com","phone_number":"+2348109994485","gender":"","address":null,"address_opt":null,"local_state":null,"country":null,"hirers_path":null,"status":"1","date_modified":"2022-05-03 11:37:06","date_created":"2022-05-03 11:37:06","username":"holynationdevelopment@gmail.com","user_type":"hirers","user_table_id":"8","last_login":"2022-05-03 13:47:13","activity_log":"1","fcm_token":"uni75y6nfdifn9","last_logout":null,"last_change_password":"2022-05-03 13:47:13"}

class SignInResponse {
  SignInResponse({
      String? token, 
      Details? details,}){
    _token = token;
    _details = details;
}

  SignInResponse.fromJson(dynamic json) {
    _token = json['token'];
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? _token;
  Details? _details;
SignInResponse copyWith({  String? token,
  Details? details,
}) => SignInResponse(  token: token ?? _token,
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

/// ID : "11"
/// fullname : "Oluwaseun Alatise"
/// email : "holynationdevelopment@gmail.com"
/// phone_number : "+2348109994485"
/// gender : ""
/// address : null
/// address_opt : null
/// local_state : null
/// country : null
/// hirers_path : null
/// status : "1"
/// date_modified : "2022-05-03 11:37:06"
/// date_created : "2022-05-03 11:37:06"
/// username : "holynationdevelopment@gmail.com"
/// user_type : "hirers"
/// user_table_id : "8"
/// last_login : "2022-05-03 13:47:13"
/// activity_log : "1"
/// fcm_token : "uni75y6nfdifn9"
/// last_logout : null
/// last_change_password : "2022-05-03 13:47:13"

class Details {
  Details({
      String? id, 
      String? fullname, 
      String? email, 
      String? phoneNumber, 
      String? gender, 
      dynamic address, 
      dynamic addressOpt, 
      dynamic localState, 
      dynamic country, 
      dynamic hirersPath, 
      String? status, 
      String? dateModified, 
      String? dateCreated, 
      String? username, 
      String? userType, 
      String? userTableId, 
      String? lastLogin, 
      String? activityLog, 
      String? fcmToken, 
      dynamic lastLogout, 
      String? lastChangePassword,}){
    _id = id;
    _fullname = fullname;
    _email = email;
    _phoneNumber = phoneNumber;
    _gender = gender;
    _address = address;
    _addressOpt = addressOpt;
    _localState = localState;
    _country = country;
    _hirersPath = hirersPath;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
    _username = username;
    _userType = userType;
    _userTableId = userTableId;
    _lastLogin = lastLogin;
    _activityLog = activityLog;
    _fcmToken = fcmToken;
    _lastLogout = lastLogout;
    _lastChangePassword = lastChangePassword;
}

  Details.fromJson(dynamic json) {
    _id = json['ID'];
    _fullname = json['fullname'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _gender = json['gender'];
    _address = json['address'];
    _addressOpt = json['address_opt'];
    _localState = json['local_state'];
    _country = json['country'];
    _hirersPath = json['hirers_path'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
    _username = json['username'];
    _userType = json['user_type'];
    _userTableId = json['user_table_id'];
    _lastLogin = json['last_login'];
    _activityLog = json['activity_log'];
    _fcmToken = json['fcm_token'];
    _lastLogout = json['last_logout'];
    _lastChangePassword = json['last_change_password'];
  }
  String? _id;
  String? _fullname;
  String? _email;
  String? _phoneNumber;
  String? _gender;
  dynamic _address;
  dynamic _addressOpt;
  dynamic _localState;
  dynamic _country;
  dynamic _hirersPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
  String? _username;
  String? _userType;
  String? _userTableId;
  String? _lastLogin;
  String? _activityLog;
  String? _fcmToken;
  dynamic _lastLogout;
  String? _lastChangePassword;
Details copyWith({  String? id,
  String? fullname,
  String? email,
  String? phoneNumber,
  String? gender,
  dynamic address,
  dynamic addressOpt,
  dynamic localState,
  dynamic country,
  dynamic hirersPath,
  String? status,
  String? dateModified,
  String? dateCreated,
  String? username,
  String? userType,
  String? userTableId,
  String? lastLogin,
  String? activityLog,
  String? fcmToken,
  dynamic lastLogout,
  String? lastChangePassword,
}) => Details(  id: id ?? _id,
  fullname: fullname ?? _fullname,
  email: email ?? _email,
  phoneNumber: phoneNumber ?? _phoneNumber,
  gender: gender ?? _gender,
  address: address ?? _address,
  addressOpt: addressOpt ?? _addressOpt,
  localState: localState ?? _localState,
  country: country ?? _country,
  hirersPath: hirersPath ?? _hirersPath,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
  username: username ?? _username,
  userType: userType ?? _userType,
  userTableId: userTableId ?? _userTableId,
  lastLogin: lastLogin ?? _lastLogin,
  activityLog: activityLog ?? _activityLog,
  fcmToken: fcmToken ?? _fcmToken,
  lastLogout: lastLogout ?? _lastLogout,
  lastChangePassword: lastChangePassword ?? _lastChangePassword,
);
  String? get id => _id;
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get gender => _gender;
  dynamic get address => _address;
  dynamic get addressOpt => _addressOpt;
  dynamic get localState => _localState;
  dynamic get country => _country;
  dynamic get hirersPath => _hirersPath;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;
  String? get username => _username;
  String? get userType => _userType;
  String? get userTableId => _userTableId;
  String? get lastLogin => _lastLogin;
  String? get activityLog => _activityLog;
  String? get fcmToken => _fcmToken;
  dynamic get lastLogout => _lastLogout;
  String? get lastChangePassword => _lastChangePassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['gender'] = _gender;
    map['address'] = _address;
    map['address_opt'] = _addressOpt;
    map['local_state'] = _localState;
    map['country'] = _country;
    map['hirers_path'] = _hirersPath;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    map['username'] = _username;
    map['user_type'] = _userType;
    map['user_table_id'] = _userTableId;
    map['last_login'] = _lastLogin;
    map['activity_log'] = _activityLog;
    map['fcm_token'] = _fcmToken;
    map['last_logout'] = _lastLogout;
    map['last_change_password'] = _lastChangePassword;
    return map;
  }

}