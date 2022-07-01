/// ID : "4"
/// equip_order_id : "4"
/// hirers_id : "8"
/// equipments_id : "3"
/// quantity : "2"
/// rental_from : "2022-06-30 20:43:58"
/// rental_to : "2022-07-02 00:00:00"
/// delivery_location : "CFWC+WF9, Victoria Arobieke St, Lekki Phase I 106104, Lagos, Nigeria"
/// request_status : "accepted"
/// date_modified : "2022-06-30 19:43:58"
/// date_created : "2022-06-30 19:10:57"
/// equip_order : {"ID":"4","hirers_id":"8","owners_id":"1","order_number":"1000000012","quantity":"2","discount":null,"total_amount":"40000","delivery_charge":"0","order_status":"accepted","order_type":"normal","pickup_date":"2022-06-30 19:43:58","latitude":"6.44733","longitude":"3.47116","payment_status":"0","date_modified":"2022-06-30 19:43:58","date_created":"2022-06-30 19:10:57"}
/// equipments : {"ID":"3","user_id":"mayomidedaniel@gmail.com","owners_id":"16","equip_name":"John Deer ","cost_of_hire":"10000","cost_of_hire_interval":"1","avail_from":"2022-06-26 00:00:00","avail_to":"2022-08-31 00:00:00","quantity":"10","description":"So cool and high HP tractor","latitude":"6.44781","longitude":"3.47235","address":"Victoria Arobieke St, Lekki Phase I 106104, Lagos, Nigeria","status":"1","date_modified":"2022-06-26 08:40:39","date_created":"2022-06-26 08:40:39","equip_images":[{"ID":"3","equipments_id":"3","equip_images_path":"https://staging.equipro.io/uploads/equip_images/image_picker4816018539018138906.jpg","status":"1","date_modified":"2022-06-26 09:40:39","date_created":"2022-06-26 09:40:39"}]}
/// extend_equip_request : {"ID":"9","hirers_id":"9","equip_request_id":"24","equip_order_id":"185","prev_equip_order":"26","rental_from":"2022-05-08 00:00:00","rental_to":"2022-05-09 00:00:00","request_status":"rejected","date_modified":"2022-05-27 17:59:44","date_created":"2022-05-24 15:52:09"}
/// equip_delivery_status : {"delivery_status":"picked_from_owner","delivery_status_lists":[{"ID":"1","delivery_status":"pending","date_modified":"2022-06-30 19:38:41","date_created":"2022-06-30 19:38:41"},{"ID":"2","delivery_status":"pending","date_modified":"2022-06-30 19:43:58","date_created":"2022-06-30 19:43:58"},{"ID":"3","delivery_status":"picked_from_owner","date_modified":"2022-06-30 20:02:24","date_created":"2022-06-30 20:02:24"}]}
/// hirers : {"ID":"8","fullname":"Oluwaseun Alatise","email":"holynationdevelopment@gmail.com","phone_number":"+2348109994485","gender":"male","address":"No 26, Gbemisola street, Allen Avenue, Ikeja","address_opt":null,"local_state":"Oyo","country":"Nigeria","latitude":null,"longitude":null,"hirers_path":null,"status":"1","date_modified":"2022-05-10 16:49:36","date_created":"2022-05-05 00:02:24"}
/// equip_payment : null

class ActiveRentalsModel {
  ActiveRentalsModel({
      String? id, 
      String? equipOrderId, 
      String? hirersId, 
      String? equipmentsId, 
      String? quantity, 
      String? rentalFrom, 
      String? rentalTo, 
      String? deliveryLocation, 
      String? requestStatus, 
      String? dateModified, 
      String? dateCreated, 
      EquipOrder? equipOrder, 
      Equipments? equipments, 
      ExtendEquipRequest? extendEquipRequest, 
      EquipDeliveryStatus? equipDeliveryStatus, 
      Hirers? hirers, 
      dynamic equipPayment,}){
    _id = id;
    _equipOrderId = equipOrderId;
    _hirersId = hirersId;
    _equipmentsId = equipmentsId;
    _quantity = quantity;
    _rentalFrom = rentalFrom;
    _rentalTo = rentalTo;
    _deliveryLocation = deliveryLocation;
    _requestStatus = requestStatus;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
    _equipOrder = equipOrder;
    _equipments = equipments;
    _extendEquipRequest = extendEquipRequest;
    _equipDeliveryStatus = equipDeliveryStatus;
    _hirers = hirers;
    _equipPayment = equipPayment;
}

  ActiveRentalsModel.fromJson(dynamic json) {
    _id = json['ID'];
    _equipOrderId = json['equip_order_id'];
    _hirersId = json['hirers_id'];
    _equipmentsId = json['equipments_id'];
    _quantity = json['quantity'];
    _rentalFrom = json['rental_from'];
    _rentalTo = json['rental_to'];
    _deliveryLocation = json['delivery_location'];
    _requestStatus = json['request_status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
    _equipOrder = json['equip_order'] != null ? EquipOrder.fromJson(json['equip_order']) : null;
    _equipments = json['equipments'] != null ? Equipments.fromJson(json['equipments']) : null;
    _extendEquipRequest = json['extend_equip_request'] != null ? ExtendEquipRequest.fromJson(json['extend_equip_request']) : null;
    _equipDeliveryStatus = json['equip_delivery_status'] != null ? EquipDeliveryStatus.fromJson(json['equip_delivery_status']) : null;
    _hirers = json['hirers'] != null ? Hirers.fromJson(json['hirers']) : null;
    _equipPayment = json['equip_payment'];
  }
  String? _id;
  String? _equipOrderId;
  String? _hirersId;
  String? _equipmentsId;
  String? _quantity;
  String? _rentalFrom;
  String? _rentalTo;
  String? _deliveryLocation;
  String? _requestStatus;
  String? _dateModified;
  String? _dateCreated;
  EquipOrder? _equipOrder;
  Equipments? _equipments;
  ExtendEquipRequest? _extendEquipRequest;
  EquipDeliveryStatus? _equipDeliveryStatus;
  Hirers? _hirers;
  dynamic _equipPayment;
ActiveRentalsModel copyWith({  String? id,
  String? equipOrderId,
  String? hirersId,
  String? equipmentsId,
  String? quantity,
  String? rentalFrom,
  String? rentalTo,
  String? deliveryLocation,
  String? requestStatus,
  String? dateModified,
  String? dateCreated,
  EquipOrder? equipOrder,
  Equipments? equipments,
  ExtendEquipRequest? extendEquipRequest,
  EquipDeliveryStatus? equipDeliveryStatus,
  Hirers? hirers,
  dynamic equipPayment,
}) => ActiveRentalsModel(  id: id ?? _id,
  equipOrderId: equipOrderId ?? _equipOrderId,
  hirersId: hirersId ?? _hirersId,
  equipmentsId: equipmentsId ?? _equipmentsId,
  quantity: quantity ?? _quantity,
  rentalFrom: rentalFrom ?? _rentalFrom,
  rentalTo: rentalTo ?? _rentalTo,
  deliveryLocation: deliveryLocation ?? _deliveryLocation,
  requestStatus: requestStatus ?? _requestStatus,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
  equipOrder: equipOrder ?? _equipOrder,
  equipments: equipments ?? _equipments,
  extendEquipRequest: extendEquipRequest ?? _extendEquipRequest,
  equipDeliveryStatus: equipDeliveryStatus ?? _equipDeliveryStatus,
  hirers: hirers ?? _hirers,
  equipPayment: equipPayment ?? _equipPayment,
);
  String? get id => _id;
  String? get equipOrderId => _equipOrderId;
  String? get hirersId => _hirersId;
  String? get equipmentsId => _equipmentsId;
  String? get quantity => _quantity;
  String? get rentalFrom => _rentalFrom;
  String? get rentalTo => _rentalTo;
  String? get deliveryLocation => _deliveryLocation;
  String? get requestStatus => _requestStatus;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;
  EquipOrder? get equipOrder => _equipOrder;
  Equipments? get equipments => _equipments;
  ExtendEquipRequest? get extendEquipRequest => _extendEquipRequest;
  EquipDeliveryStatus? get equipDeliveryStatus => _equipDeliveryStatus;
  Hirers? get hirers => _hirers;
  dynamic get equipPayment => _equipPayment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['equip_order_id'] = _equipOrderId;
    map['hirers_id'] = _hirersId;
    map['equipments_id'] = _equipmentsId;
    map['quantity'] = _quantity;
    map['rental_from'] = _rentalFrom;
    map['rental_to'] = _rentalTo;
    map['delivery_location'] = _deliveryLocation;
    map['request_status'] = _requestStatus;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    if (_equipOrder != null) {
      map['equip_order'] = _equipOrder?.toJson();
    }
    if (_equipments != null) {
      map['equipments'] = _equipments?.toJson();
    }
    if (_extendEquipRequest != null) {
      map['extend_equip_request'] = _extendEquipRequest?.toJson();
    }
    if (_equipDeliveryStatus != null) {
      map['equip_delivery_status'] = _equipDeliveryStatus?.toJson();
    }
    if (_hirers != null) {
      map['hirers'] = _hirers?.toJson();
    }
    map['equip_payment'] = _equipPayment;
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
/// latitude : null
/// longitude : null
/// hirers_path : null
/// status : "1"
/// date_modified : "2022-05-10 16:49:36"
/// date_created : "2022-05-05 00:02:24"

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
      dynamic latitude, 
      dynamic longitude, 
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
    _latitude = latitude;
    _longitude = longitude;
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
    _latitude = json['latitude'];
    _longitude = json['longitude'];
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
  dynamic _latitude;
  dynamic _longitude;
  dynamic _hirersPath;
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
  dynamic latitude,
  dynamic longitude,
  dynamic hirersPath,
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
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
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
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
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
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['hirers_path'] = _hirersPath;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}

/// delivery_status : "picked_from_owner"
/// delivery_status_lists : [{"ID":"1","delivery_status":"pending","date_modified":"2022-06-30 19:38:41","date_created":"2022-06-30 19:38:41"},{"ID":"2","delivery_status":"pending","date_modified":"2022-06-30 19:43:58","date_created":"2022-06-30 19:43:58"},{"ID":"3","delivery_status":"picked_from_owner","date_modified":"2022-06-30 20:02:24","date_created":"2022-06-30 20:02:24"}]

class EquipDeliveryStatus {
  EquipDeliveryStatus({
      String? deliveryStatus, 
      List<DeliveryStatusLists>? deliveryStatusLists,}){
    _deliveryStatus = deliveryStatus;
    _deliveryStatusLists = deliveryStatusLists;
}

  EquipDeliveryStatus.fromJson(dynamic json) {
    _deliveryStatus = json['delivery_status'];
    if (json['delivery_status_lists'] != null) {
      _deliveryStatusLists = [];
      json['delivery_status_lists'].forEach((v) {
        _deliveryStatusLists?.add(DeliveryStatusLists.fromJson(v));
      });
    }
  }
  String? _deliveryStatus;
  List<DeliveryStatusLists>? _deliveryStatusLists;
EquipDeliveryStatus copyWith({  String? deliveryStatus,
  List<DeliveryStatusLists>? deliveryStatusLists,
}) => EquipDeliveryStatus(  deliveryStatus: deliveryStatus ?? _deliveryStatus,
  deliveryStatusLists: deliveryStatusLists ?? _deliveryStatusLists,
);
  String? get deliveryStatus => _deliveryStatus;
  List<DeliveryStatusLists>? get deliveryStatusLists => _deliveryStatusLists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['delivery_status'] = _deliveryStatus;
    if (_deliveryStatusLists != null) {
      map['delivery_status_lists'] = _deliveryStatusLists?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "1"
/// delivery_status : "pending"
/// date_modified : "2022-06-30 19:38:41"
/// date_created : "2022-06-30 19:38:41"

class DeliveryStatusLists {
  DeliveryStatusLists({
      String? id, 
      String? deliveryStatus, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _deliveryStatus = deliveryStatus;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  DeliveryStatusLists.fromJson(dynamic json) {
    _id = json['ID'];
    _deliveryStatus = json['delivery_status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _deliveryStatus;
  String? _dateModified;
  String? _dateCreated;
DeliveryStatusLists copyWith({  String? id,
  String? deliveryStatus,
  String? dateModified,
  String? dateCreated,
}) => DeliveryStatusLists(  id: id ?? _id,
  deliveryStatus: deliveryStatus ?? _deliveryStatus,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get deliveryStatus => _deliveryStatus;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['delivery_status'] = _deliveryStatus;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}

/// ID : "9"
/// hirers_id : "9"
/// equip_request_id : "24"
/// equip_order_id : "185"
/// prev_equip_order : "26"
/// rental_from : "2022-05-08 00:00:00"
/// rental_to : "2022-05-09 00:00:00"
/// request_status : "rejected"
/// date_modified : "2022-05-27 17:59:44"
/// date_created : "2022-05-24 15:52:09"

class ExtendEquipRequest {
  ExtendEquipRequest({
      String? id, 
      String? hirersId, 
      String? equipRequestId, 
      String? equipOrderId, 
      String? prevEquipOrder, 
      String? rentalFrom, 
      String? rentalTo, 
      String? requestStatus, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _hirersId = hirersId;
    _equipRequestId = equipRequestId;
    _equipOrderId = equipOrderId;
    _prevEquipOrder = prevEquipOrder;
    _rentalFrom = rentalFrom;
    _rentalTo = rentalTo;
    _requestStatus = requestStatus;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  ExtendEquipRequest.fromJson(dynamic json) {
    _id = json['ID'];
    _hirersId = json['hirers_id'];
    _equipRequestId = json['equip_request_id'];
    _equipOrderId = json['equip_order_id'];
    _prevEquipOrder = json['prev_equip_order'];
    _rentalFrom = json['rental_from'];
    _rentalTo = json['rental_to'];
    _requestStatus = json['request_status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _hirersId;
  String? _equipRequestId;
  String? _equipOrderId;
  String? _prevEquipOrder;
  String? _rentalFrom;
  String? _rentalTo;
  String? _requestStatus;
  String? _dateModified;
  String? _dateCreated;
ExtendEquipRequest copyWith({  String? id,
  String? hirersId,
  String? equipRequestId,
  String? equipOrderId,
  String? prevEquipOrder,
  String? rentalFrom,
  String? rentalTo,
  String? requestStatus,
  String? dateModified,
  String? dateCreated,
}) => ExtendEquipRequest(  id: id ?? _id,
  hirersId: hirersId ?? _hirersId,
  equipRequestId: equipRequestId ?? _equipRequestId,
  equipOrderId: equipOrderId ?? _equipOrderId,
  prevEquipOrder: prevEquipOrder ?? _prevEquipOrder,
  rentalFrom: rentalFrom ?? _rentalFrom,
  rentalTo: rentalTo ?? _rentalTo,
  requestStatus: requestStatus ?? _requestStatus,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get hirersId => _hirersId;
  String? get equipRequestId => _equipRequestId;
  String? get equipOrderId => _equipOrderId;
  String? get prevEquipOrder => _prevEquipOrder;
  String? get rentalFrom => _rentalFrom;
  String? get rentalTo => _rentalTo;
  String? get requestStatus => _requestStatus;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['hirers_id'] = _hirersId;
    map['equip_request_id'] = _equipRequestId;
    map['equip_order_id'] = _equipOrderId;
    map['prev_equip_order'] = _prevEquipOrder;
    map['rental_from'] = _rentalFrom;
    map['rental_to'] = _rentalTo;
    map['request_status'] = _requestStatus;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}

/// ID : "3"
/// user_id : "mayomidedaniel@gmail.com"
/// owners_id : "16"
/// equip_name : "John Deer "
/// cost_of_hire : "10000"
/// cost_of_hire_interval : "1"
/// avail_from : "2022-06-26 00:00:00"
/// avail_to : "2022-08-31 00:00:00"
/// quantity : "10"
/// description : "So cool and high HP tractor"
/// latitude : "6.44781"
/// longitude : "3.47235"
/// address : "Victoria Arobieke St, Lekki Phase I 106104, Lagos, Nigeria"
/// status : "1"
/// date_modified : "2022-06-26 08:40:39"
/// date_created : "2022-06-26 08:40:39"
/// equip_images : [{"ID":"3","equipments_id":"3","equip_images_path":"https://staging.equipro.io/uploads/equip_images/image_picker4816018539018138906.jpg","status":"1","date_modified":"2022-06-26 09:40:39","date_created":"2022-06-26 09:40:39"}]

class Equipments {
  Equipments({
      String? id, 
      String? userId, 
      String? ownersId, 
      String? equipName, 
      String? costOfHire, 
      String? costOfHireInterval, 
      String? availFrom, 
      String? availTo, 
      String? quantity, 
      String? description, 
      String? latitude, 
      String? longitude, 
      String? address, 
      String? status, 
      String? dateModified, 
      String? dateCreated, 
      List<EquipImages>? equipImages,}){
    _id = id;
    _userId = userId;
    _ownersId = ownersId;
    _equipName = equipName;
    _costOfHire = costOfHire;
    _costOfHireInterval = costOfHireInterval;
    _availFrom = availFrom;
    _availTo = availTo;
    _quantity = quantity;
    _description = description;
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
    _equipImages = equipImages;
}

  Equipments.fromJson(dynamic json) {
    _id = json['ID'];
    _userId = json['user_id'];
    _ownersId = json['owners_id'];
    _equipName = json['equip_name'];
    _costOfHire = json['cost_of_hire'];
    _costOfHireInterval = json['cost_of_hire_interval'];
    _availFrom = json['avail_from'];
    _availTo = json['avail_to'];
    _quantity = json['quantity'];
    _description = json['description'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _address = json['address'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
    if (json['equip_images'] != null) {
      _equipImages = [];
      json['equip_images'].forEach((v) {
        _equipImages?.add(EquipImages.fromJson(v));
      });
    }
  }
  String? _id;
  String? _userId;
  String? _ownersId;
  String? _equipName;
  String? _costOfHire;
  String? _costOfHireInterval;
  String? _availFrom;
  String? _availTo;
  String? _quantity;
  String? _description;
  String? _latitude;
  String? _longitude;
  String? _address;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
  List<EquipImages>? _equipImages;
Equipments copyWith({  String? id,
  String? userId,
  String? ownersId,
  String? equipName,
  String? costOfHire,
  String? costOfHireInterval,
  String? availFrom,
  String? availTo,
  String? quantity,
  String? description,
  String? latitude,
  String? longitude,
  String? address,
  String? status,
  String? dateModified,
  String? dateCreated,
  List<EquipImages>? equipImages,
}) => Equipments(  id: id ?? _id,
  userId: userId ?? _userId,
  ownersId: ownersId ?? _ownersId,
  equipName: equipName ?? _equipName,
  costOfHire: costOfHire ?? _costOfHire,
  costOfHireInterval: costOfHireInterval ?? _costOfHireInterval,
  availFrom: availFrom ?? _availFrom,
  availTo: availTo ?? _availTo,
  quantity: quantity ?? _quantity,
  description: description ?? _description,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  address: address ?? _address,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
  equipImages: equipImages ?? _equipImages,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get ownersId => _ownersId;
  String? get equipName => _equipName;
  String? get costOfHire => _costOfHire;
  String? get costOfHireInterval => _costOfHireInterval;
  String? get availFrom => _availFrom;
  String? get availTo => _availTo;
  String? get quantity => _quantity;
  String? get description => _description;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get address => _address;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;
  List<EquipImages>? get equipImages => _equipImages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['user_id'] = _userId;
    map['owners_id'] = _ownersId;
    map['equip_name'] = _equipName;
    map['cost_of_hire'] = _costOfHire;
    map['cost_of_hire_interval'] = _costOfHireInterval;
    map['avail_from'] = _availFrom;
    map['avail_to'] = _availTo;
    map['quantity'] = _quantity;
    map['description'] = _description;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['address'] = _address;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    if (_equipImages != null) {
      map['equip_images'] = _equipImages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "3"
/// equipments_id : "3"
/// equip_images_path : "https://staging.equipro.io/uploads/equip_images/image_picker4816018539018138906.jpg"
/// status : "1"
/// date_modified : "2022-06-26 09:40:39"
/// date_created : "2022-06-26 09:40:39"

class EquipImages {
  EquipImages({
      String? id, 
      String? equipmentsId, 
      String? equipImagesPath, 
      String? status, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _equipmentsId = equipmentsId;
    _equipImagesPath = equipImagesPath;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  EquipImages.fromJson(dynamic json) {
    _id = json['ID'];
    _equipmentsId = json['equipments_id'];
    _equipImagesPath = json['equip_images_path'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _equipmentsId;
  String? _equipImagesPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
EquipImages copyWith({  String? id,
  String? equipmentsId,
  String? equipImagesPath,
  String? status,
  String? dateModified,
  String? dateCreated,
}) => EquipImages(  id: id ?? _id,
  equipmentsId: equipmentsId ?? _equipmentsId,
  equipImagesPath: equipImagesPath ?? _equipImagesPath,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get equipmentsId => _equipmentsId;
  String? get equipImagesPath => _equipImagesPath;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['equipments_id'] = _equipmentsId;
    map['equip_images_path'] = _equipImagesPath;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}

/// ID : "4"
/// hirers_id : "8"
/// owners_id : "1"
/// order_number : "1000000012"
/// quantity : "2"
/// discount : null
/// total_amount : "40000"
/// delivery_charge : "0"
/// order_status : "accepted"
/// order_type : "normal"
/// pickup_date : "2022-06-30 19:43:58"
/// latitude : "6.44733"
/// longitude : "3.47116"
/// payment_status : "0"
/// date_modified : "2022-06-30 19:43:58"
/// date_created : "2022-06-30 19:10:57"

class EquipOrder {
  EquipOrder({
      String? id, 
      String? hirersId, 
      String? ownersId, 
      String? orderNumber, 
      String? quantity, 
      dynamic discount, 
      String? totalAmount, 
      String? deliveryCharge, 
      String? orderStatus, 
      String? orderType, 
      String? pickupDate, 
      String? latitude, 
      String? longitude, 
      String? paymentStatus, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _hirersId = hirersId;
    _ownersId = ownersId;
    _orderNumber = orderNumber;
    _quantity = quantity;
    _discount = discount;
    _totalAmount = totalAmount;
    _deliveryCharge = deliveryCharge;
    _orderStatus = orderStatus;
    _orderType = orderType;
    _pickupDate = pickupDate;
    _latitude = latitude;
    _longitude = longitude;
    _paymentStatus = paymentStatus;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  EquipOrder.fromJson(dynamic json) {
    _id = json['ID'];
    _hirersId = json['hirers_id'];
    _ownersId = json['owners_id'];
    _orderNumber = json['order_number'];
    _quantity = json['quantity'];
    _discount = json['discount'];
    _totalAmount = json['total_amount'];
    _deliveryCharge = json['delivery_charge'];
    _orderStatus = json['order_status'];
    _orderType = json['order_type'];
    _pickupDate = json['pickup_date'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _paymentStatus = json['payment_status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _hirersId;
  String? _ownersId;
  String? _orderNumber;
  String? _quantity;
  dynamic _discount;
  String? _totalAmount;
  String? _deliveryCharge;
  String? _orderStatus;
  String? _orderType;
  String? _pickupDate;
  String? _latitude;
  String? _longitude;
  String? _paymentStatus;
  String? _dateModified;
  String? _dateCreated;
EquipOrder copyWith({  String? id,
  String? hirersId,
  String? ownersId,
  String? orderNumber,
  String? quantity,
  dynamic discount,
  String? totalAmount,
  String? deliveryCharge,
  String? orderStatus,
  String? orderType,
  String? pickupDate,
  String? latitude,
  String? longitude,
  String? paymentStatus,
  String? dateModified,
  String? dateCreated,
}) => EquipOrder(  id: id ?? _id,
  hirersId: hirersId ?? _hirersId,
  ownersId: ownersId ?? _ownersId,
  orderNumber: orderNumber ?? _orderNumber,
  quantity: quantity ?? _quantity,
  discount: discount ?? _discount,
  totalAmount: totalAmount ?? _totalAmount,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  orderStatus: orderStatus ?? _orderStatus,
  orderType: orderType ?? _orderType,
  pickupDate: pickupDate ?? _pickupDate,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  paymentStatus: paymentStatus ?? _paymentStatus,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get hirersId => _hirersId;
  String? get ownersId => _ownersId;
  String? get orderNumber => _orderNumber;
  String? get quantity => _quantity;
  dynamic get discount => _discount;
  String? get totalAmount => _totalAmount;
  String? get deliveryCharge => _deliveryCharge;
  String? get orderStatus => _orderStatus;
  String? get orderType => _orderType;
  String? get pickupDate => _pickupDate;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get paymentStatus => _paymentStatus;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['hirers_id'] = _hirersId;
    map['owners_id'] = _ownersId;
    map['order_number'] = _orderNumber;
    map['quantity'] = _quantity;
    map['discount'] = _discount;
    map['total_amount'] = _totalAmount;
    map['delivery_charge'] = _deliveryCharge;
    map['order_status'] = _orderStatus;
    map['order_type'] = _orderType;
    map['pickup_date'] = _pickupDate;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['payment_status'] = _paymentStatus;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}