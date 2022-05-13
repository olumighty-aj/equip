/// ID : "4"
/// user_id : "11"
/// owners_id : "1"
/// equip_name : "Wheel Barrow"
/// equip_images_id : "4"
/// cost_of_hire : "1000"
/// cost_of_hire_interval : "7"
/// avail_from : "2022-05-05 00:00:00"
/// avail_to : "2022-12-25 00:00:00"
/// quantity : "12"
/// description : "This is a wheelbarrow useful for farming and item carriage"
/// status : "1"
/// date_modified : "2022-05-10 16:49:36"
/// date_created : "2022-05-05 02:57:30"
/// equip_images : [{"ID":"4","equipments_id":"Wheel Barrow","equip_images_path":"/var/www/holynation/gig/equipro/writable/uploads/equipments/1651719451_bdebd019a0dc4d5f6b43.txt","status":"1","date_created":"2022-05-05 03:57:31"}]
/// owners : {"ID":"8","fullname":"Oluwaseun Alatise","email":"holynationdevelopment@gmail.com","phone_number":"+2348109994485","gender":"male","address":"No 26, Gbemisola street, Allen Avenue, Ikeja","address_opt":null,"local_state":"Oyo","country":"Nigeria","hirers_path":null,"status":"1","date_modified":"2022-05-10 16:49:36","date_created":"2022-05-05 00:02:24"}
/// reviews : []
/// average_rating : 0

class EquipmentModel {
  EquipmentModel({
      String? id, 
      String? userId, 
      String? ownersId, 
      String? equipName, 
      String? equipImagesId, 
      String? costOfHire, 
      String? costOfHireInterval, 
      String? availFrom, 
      String? availTo, 
      String? quantity, 
      String? description, 
      String? status, 
      String? dateModified, 
      String? dateCreated, 
      List<EquipImages>? equipImages, 
      Owners? owners, 
      List<dynamic>? reviews,
    dynamic? averageRating,}){
    _id = id;
    _userId = userId;
    _ownersId = ownersId;
    _equipName = equipName;
    _equipImagesId = equipImagesId;
    _costOfHire = costOfHire;
    _costOfHireInterval = costOfHireInterval;
    _availFrom = availFrom;
    _availTo = availTo;
    _quantity = quantity;
    _description = description;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
    _equipImages = equipImages;
    _owners = owners;
    _reviews = reviews;
    _averageRating = averageRating;
}

  EquipmentModel.fromJson(dynamic json) {
    _id = json['ID'];
    _userId = json['user_id'];
    _ownersId = json['owners_id'];
    _equipName = json['equip_name'];
    _equipImagesId = json['equip_images_id'];
    _costOfHire = json['cost_of_hire'];
    _costOfHireInterval = json['cost_of_hire_interval'];
    _availFrom = json['avail_from'];
    _availTo = json['avail_to'];
    _quantity = json['quantity'];
    _description = json['description'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
    if (json['equip_images'] != null) {
      _equipImages = [];
      json['equip_images'].forEach((v) {
        _equipImages?.add(EquipImages.fromJson(v));
      });
    }
    _owners = json['owners'] != null ? Owners.fromJson(json['owners']) : null;
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
       // _reviews?.add(Dynamic.fromJson(v));
      });
    }
    _averageRating = json['average_rating'];
  }
  String? _id;
  String? _userId;
  String? _ownersId;
  String? _equipName;
  String? _equipImagesId;
  String? _costOfHire;
  String? _costOfHireInterval;
  String? _availFrom;
  String? _availTo;
  String? _quantity;
  String? _description;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
  List<EquipImages>? _equipImages;
  Owners? _owners;
  List<dynamic>? _reviews;
  dynamic _averageRating;
EquipmentModel copyWith({  String? id,
  String? userId,
  String? ownersId,
  String? equipName,
  String? equipImagesId,
  String? costOfHire,
  String? costOfHireInterval,
  String? availFrom,
  String? availTo,
  String? quantity,
  String? description,
  String? status,
  String? dateModified,
  String? dateCreated,
  List<EquipImages>? equipImages,
  Owners? owners,
  List<dynamic>? reviews,
  dynamic averageRating,
}) => EquipmentModel(  id: id ?? _id,
  userId: userId ?? _userId,
  ownersId: ownersId ?? _ownersId,
  equipName: equipName ?? _equipName,
  equipImagesId: equipImagesId ?? _equipImagesId,
  costOfHire: costOfHire ?? _costOfHire,
  costOfHireInterval: costOfHireInterval ?? _costOfHireInterval,
  availFrom: availFrom ?? _availFrom,
  availTo: availTo ?? _availTo,
  quantity: quantity ?? _quantity,
  description: description ?? _description,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
  equipImages: equipImages ?? _equipImages,
  owners: owners ?? _owners,
  reviews: reviews ?? _reviews,
  averageRating: averageRating ?? _averageRating,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get ownersId => _ownersId;
  String? get equipName => _equipName;
  String? get equipImagesId => _equipImagesId;
  String? get costOfHire => _costOfHire;
  String? get costOfHireInterval => _costOfHireInterval;
  String? get availFrom => _availFrom;
  String? get availTo => _availTo;
  String? get quantity => _quantity;
  String? get description => _description;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;
  List<EquipImages>? get equipImages => _equipImages;
  Owners? get owners => _owners;
  List<dynamic>? get reviews => _reviews;
  dynamic get averageRating => _averageRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['user_id'] = _userId;
    map['owners_id'] = _ownersId;
    map['equip_name'] = _equipName;
    map['equip_images_id'] = _equipImagesId;
    map['cost_of_hire'] = _costOfHire;
    map['cost_of_hire_interval'] = _costOfHireInterval;
    map['avail_from'] = _availFrom;
    map['avail_to'] = _availTo;
    map['quantity'] = _quantity;
    map['description'] = _description;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    if (_equipImages != null) {
      map['equip_images'] = _equipImages?.map((v) => v.toJson()).toList();
    }
    if (_owners != null) {
      map['owners'] = _owners?.toJson();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    map['average_rating'] = _averageRating;
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
/// hirers_path : null
/// status : "1"
/// date_modified : "2022-05-10 16:49:36"
/// date_created : "2022-05-05 00:02:24"

class Owners {
  Owners({
      String? id, 
      String? fullname, 
      String? email, 
      String? phoneNumber, 
      String? gender, 
      String? address, 
      dynamic addressOpt, 
      String? localState, 
      String? country, 
      dynamic hirersPath, 
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

  Owners.fromJson(dynamic json) {
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
  dynamic _hirersPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
Owners copyWith({  String? id,
  String? fullname,
  String? email,
  String? phoneNumber,
  String? gender,
  String? address,
  dynamic addressOpt,
  String? localState,
  String? country,
  dynamic hirersPath,
  String? status,
  String? dateModified,
  String? dateCreated,
}) => Owners(  id: id ?? _id,
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
  dynamic get hirersPath => _hirersPath;
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

/// ID : "4"
/// equipments_id : "Wheel Barrow"
/// equip_images_path : "/var/www/holynation/gig/equipro/writable/uploads/equipments/1651719451_bdebd019a0dc4d5f6b43.txt"
/// status : "1"
/// date_created : "2022-05-05 03:57:31"

class EquipImages {
  EquipImages({
      String? id, 
      String? equipmentsId, 
      String? equipImagesPath, 
      String? status, 
      String? dateCreated,}){
    _id = id;
    _equipmentsId = equipmentsId;
    _equipImagesPath = equipImagesPath;
    _status = status;
    _dateCreated = dateCreated;
}

  EquipImages.fromJson(dynamic json) {
    _id = json['ID'];
    _equipmentsId = json['equipments_id'];
    _equipImagesPath = json['equip_images_path'];
    _status = json['status'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _equipmentsId;
  String? _equipImagesPath;
  String? _status;
  String? _dateCreated;
EquipImages copyWith({  String? id,
  String? equipmentsId,
  String? equipImagesPath,
  String? status,
  String? dateCreated,
}) => EquipImages(  id: id ?? _id,
  equipmentsId: equipmentsId ?? _equipmentsId,
  equipImagesPath: equipImagesPath ?? _equipImagesPath,
  status: status ?? _status,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get equipmentsId => _equipmentsId;
  String? get equipImagesPath => _equipImagesPath;
  String? get status => _status;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['equipments_id'] = _equipmentsId;
    map['equip_images_path'] = _equipImagesPath;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    return map;
  }

}