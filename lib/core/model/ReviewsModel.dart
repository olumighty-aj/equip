/// ID : "6"
/// hirers_id : "8"
/// is_owners : true
/// equipments_id : "3"
/// comment : "Mr Holynation Developer returned my equipment in good shape"
/// rating : "3.5"
/// date_created : "2022-06-04 13:07:39"
/// hirers : {"ID":"8","fullname":"Oluwaseun Alatise","email":"holynationdevelopment@gmail.com","phone_number":"+2348109994485","gender":"male","address":"No 26, Gbemisola street, Allen Avenue, Ikeja","address_opt":null,"local_state":"Oyo","country":"Nigeria","hirers_path":"http://localhost/gig/equipro/public/uploads/hirers/34ef022624a898f02776d2d050_2022-05-14.png","status":"1","date_modified":"2022-05-14 02:48:28","date_created":"2022-05-14 02:48:28"}

class ReviewsModel {
  ReviewsModel({
      String? id, 
      String? hirersId, 
      bool? isOwners, 
      String? equipmentsId, 
      String? comment, 
      String? rating, 
      String? dateCreated, 
      Hirers? hirers,}){
    _id = id;
    _hirersId = hirersId;
    _isOwners = isOwners;
    _equipmentsId = equipmentsId;
    _comment = comment;
    _rating = rating;
    _dateCreated = dateCreated;
    _hirers = hirers;
}

  ReviewsModel.fromJson(dynamic json) {
    _id = json['ID'];
    _hirersId = json['hirers_id'];
    _isOwners = json['is_owners'];
    _equipmentsId = json['equipments_id'];
    _comment = json['comment'];
    _rating = json['rating'];
    _dateCreated = json['date_created'];
    _hirers = json['hirers'] != null ? Hirers.fromJson(json['hirers']) : null;
  }
  String? _id;
  String? _hirersId;
  bool? _isOwners;
  String? _equipmentsId;
  String? _comment;
  String? _rating;
  String? _dateCreated;
  Hirers? _hirers;
ReviewsModel copyWith({  String? id,
  String? hirersId,
  bool? isOwners,
  String? equipmentsId,
  String? comment,
  String? rating,
  String? dateCreated,
  Hirers? hirers,
}) => ReviewsModel(  id: id ?? _id,
  hirersId: hirersId ?? _hirersId,
  isOwners: isOwners ?? _isOwners,
  equipmentsId: equipmentsId ?? _equipmentsId,
  comment: comment ?? _comment,
  rating: rating ?? _rating,
  dateCreated: dateCreated ?? _dateCreated,
  hirers: hirers ?? _hirers,
);
  String? get id => _id;
  String? get hirersId => _hirersId;
  bool? get isOwners => _isOwners;
  String? get equipmentsId => _equipmentsId;
  String? get comment => _comment;
  String? get rating => _rating;
  String? get dateCreated => _dateCreated;
  Hirers? get hirers => _hirers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['hirers_id'] = _hirersId;
    map['is_owners'] = _isOwners;
    map['equipments_id'] = _equipmentsId;
    map['comment'] = _comment;
    map['rating'] = _rating;
    map['date_created'] = _dateCreated;
    if (_hirers != null) {
      map['hirers'] = _hirers?.toJson();
    }
    return map;
  }

}

/// ID : "8"
/// fullname : "Oluwaseun Alatise"
/// email : "holynationdevelopment@gmail.com"
/// phone_number : "+2348109994485"
/// gender : "male"
/// address : "No 26, Gbemisola street, Allen Avenue, Ikeja"
/// address_opt : null
/// local_state : "Oyo"
/// country : "Nigeria"
/// hirers_path : "http://localhost/gig/equipro/public/uploads/hirers/34ef022624a898f02776d2d050_2022-05-14.png"
/// status : "1"
/// date_modified : "2022-05-14 02:48:28"
/// date_created : "2022-05-14 02:48:28"

class Hirers {
  Hirers({
      String? id, 
      String? fullname, 
      String? email, 
      String? phoneNumber, 
      String? gender, 
      String? address, 
      dynamic addressOpt, 
      String? localState, 
      String? country, 
      String? hirersPath, 
      String? status, 
      String? dateModified, 
      String? dateCreated,}){
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
}

  Hirers.fromJson(dynamic json) {
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
  }
  String? _id;
  String? _fullname;
  String? _email;
  String? _phoneNumber;
  String? _gender;
  String? _address;
  dynamic _addressOpt;
  String? _localState;
  String? _country;
  String? _hirersPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
Hirers copyWith({  String? id,
  String? fullname,
  String? email,
  String? phoneNumber,
  String? gender,
  String? address,
  dynamic addressOpt,
  String? localState,
  String? country,
  String? hirersPath,
  String? status,
  String? dateModified,
  String? dateCreated,
}) => Hirers(  id: id ?? _id,
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
);
  String? get id => _id;
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get gender => _gender;
  String? get address => _address;
  dynamic get addressOpt => _addressOpt;
  String? get localState => _localState;
  String? get country => _country;
  String? get hirersPath => _hirersPath;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

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
    return map;
  }

}