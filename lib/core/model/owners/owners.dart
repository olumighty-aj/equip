// class Owners {
//   Owners({
//     String? id,
//     String? fullname,
//     String? email,
//     String? phoneNumber,
//     String? gender,
//     String? local_state,
//     String? address,
//     dynamic addressOpt,
//     String? localState,
//     String? country,
//     String? latitude,
//     String? longitude,
//     String? hirersPath,
//     String? status,
//     String? dateModified,
//     String? dateCreated,
//   }) {
//     _id = id;
//     _fullname = fullname;
//     _email = email;
//     _phoneNumber = phoneNumber;
//     _gender = gender;
//     _localState = local_state;
//     _address = address;
//     _addressOpt = addressOpt;
//     _localState = localState;
//     _country = country;
//     _latitude = latitude;
//     _longitude = longitude;
//     _hirersPath = hirersPath;
//     _status = status;
//     _dateModified = dateModified;
//     _dateCreated = dateCreated;
//   }
//
//   Owners.fromJson(dynamic json) {
//     _id = json['ID'];
//     _fullname = json['fullname'];
//     _email = json['email'];
//     _phoneNumber = json['phone_number'];
//     _gender = json['gender'];
//     _localState = json['local_state'];
//     _address = json['address'];
//     _addressOpt = json['address_opt'];
//     _localState = json['local_state'];
//     _country = json['country'];
//     _latitude = json['latitude'];
//     _longitude = json['longitude'];
//     _hirersPath = json['hirers_path'];
//     _status = json['status'];
//     _dateModified = json['date_modified'];
//     _dateCreated = json['date_created'];
//   }
//   String? _id;
//   String? _fullname;
//   String? _email;
//   String? _phoneNumber;
//   String? _gender;
//   String? _address;
//   dynamic _addressOpt;
//   String? _localState;
//   String? _country;
//   String? _latitude;
//   String? _longitude;
//   String? _hirersPath;
//   String? _status;
//   String? _dateModified;
//   String? _dateCreated;
//   Owners copyWith({
//     String? id,
//     String? fullname,
//     String? email,
//     String? phoneNumber,
//     String? gender,
//     String? address,
//     dynamic addressOpt,
//     String? localState,
//     String? country,
//     String? latitude,
//     String? longitude,
//     String? hirersPath,
//     String? status,
//     // String? localState,
//     String? dateModified,
//     String? dateCreated,
//   }) =>
//       Owners(
//         id: id ?? _id,
//         fullname: fullname ?? _fullname,
//         email: email ?? _email,
//         phoneNumber: phoneNumber ?? _phoneNumber,
//         gender: gender ?? _gender,
//         local_state: _localState,
//         address: address ?? _address,
//         addressOpt: addressOpt ?? _addressOpt,
//         localState: localState ?? _localState,
//         country: country ?? _country,
//         latitude: latitude ?? _latitude,
//         longitude: longitude ?? _longitude,
//         hirersPath: hirersPath ?? _hirersPath,
//         status: status ?? _status,
//         dateModified: dateModified ?? _dateModified,
//         dateCreated: dateCreated ?? _dateCreated,
//       );
//   String? get id => _id;
//   String? get fullname => _fullname;
//   String? get email => _email;
//   String? get phoneNumber => _phoneNumber;
//   String? get gender => _gender;
//   String? get address => _address;
//   String? get localState => _localState;
//   dynamic get addressOpt => _addressOpt;
//   // String? get local_State => _localState;
//   String? get country => _country;
//   String? get latitude => _latitude;
//   String? get longitude => _longitude;
//   String? get hirersPath => _hirersPath;
//   String? get status => _status;
//   String? get dateModified => _dateModified;
//   String? get dateCreated => _dateCreated;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ID'] = _id;
//     map['local_state'] = _localState;
//     map['fullname'] = _fullname;
//     map['email'] = _email;
//     map['phone_number'] = _phoneNumber;
//     map['gender'] = _gender;
//     map['address'] = _address;
//     map['address_opt'] = _addressOpt;
//     map['local_state'] = _localState;
//     map['country'] = _country;
//     map['latitude'] = _latitude;
//     map['longitude'] = _longitude;
//     map['hirers_path'] = _hirersPath;
//     map['status'] = _status;
//     map['date_modified'] = _dateModified;
//     map['date_created'] = _dateCreated;
//     return map;
//   }
// }

import 'package:json_annotation/json_annotation.dart';

part 'owners.g.dart';

@JsonSerializable()
class Owners {
  String? id;
  String? fullname;
  String? email;
  String? phone_number;
  String? gender;
  String? local_state;
  String? address;
  dynamic address_opt;
  String? country;
  String? latitude;
  String? longitude;
  String? hirers_path;
  String? status;
  String? date_modified;
  String? date_created;

  Owners({
    this.id,
    this.fullname,
    this.email,
    this.phone_number,
    this.gender,
    this.local_state,
    this.address,
    this.address_opt,
    this.country,
    this.latitude,
    this.longitude,
    this.hirers_path,
    this.status,
    this.date_modified,
    this.date_created,
  });

  factory Owners.fromJson(Map<String, dynamic> json) => _$OwnersFromJson(json);

  Map<String, dynamic> toJson() => _$OwnersToJson(this);
}
