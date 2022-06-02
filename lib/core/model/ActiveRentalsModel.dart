/// ID : "24"
/// equip_order_id : "26"
/// hirers_id : "9"
/// equipments_id : "2"
/// quantity : "3"
/// rental_from : "2022-05-07 00:00:00"
/// rental_to : "2022-05-08 00:00:00"
/// delivery_location : "No 10, Kwara road, Ibadan"
/// request_status : "returned"
/// date_modified : "2022-06-02 12:24:16"
/// date_created : "2022-05-08 15:45:58"
/// equip_order : {"ID":"26","hirers_id":"9","owners_id":"1","order_number":"1000000014","quantity":"3","discount":null,"total_amount":"2142.86","delivery_charge":"0","order_status":"rejected","order_type":"normal","pickup_date":"2022-05-10 00:00:00","payment_status":"0","date_modified":"2022-05-26 20:04:10","date_created":"2022-05-08 15:21:23"}
/// equipments : {"ID":"2","user_id":"holynationdevelopment@gmail.com","owners_id":"11","equip_name":"Bulldozer","equip_images_id":"/var/www/holynation/gig/equipro/writable/uploads/equipments/1651718951_6a63c19020a5fa15229e.png","cost_of_hire":"5000","cost_of_hire_interval":"7","avail_from":"2022-05-05 00:00:00","avail_to":"2022-12-25 00:00:00","quantity":"12","description":"This is a bulldozer useful for farming and item carriage","status":"1","date_modified":"2022-05-26 14:39:24","date_created":"2022-05-05 02:49:11"}
/// extend_equip_request : {"ID":"9","hirers_id":"9","equip_request_id":"24","equip_order_id":"185","prev_equip_order":"26","rental_from":"2022-05-08 00:00:00","rental_to":"2022-05-09 00:00:00","request_status":"rejected","date_modified":"2022-05-27 17:59:44","date_created":"2022-05-24 15:52:09"}
/// hirers : {"ID":"9","fullname":"Holynation developer","email":"holynation667@gmail.com","phone_number":"+2348109994486","gender":"","address":null,"address_opt":null,"local_state":null,"country":null,"hirers_path":null,"status":"1","date_modified":"2022-05-09 16:51:27","date_created":"2022-05-06 12:45:43"}
/// equip_payment : []

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
    //ExtendEquipRequest? extendEquipRequest,
      Hirers? hirers, 
      List<dynamic>? equipPayment,}){
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
   // _extendEquipRequest = extendEquipRequest;
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
  //  _extendEquipRequest = json['extend_equip_request'] != null ? ExtendEquipRequest.fromJson(json['extend_equip_request']) : null;
    _hirers = json['hirers'] != null ? Hirers.fromJson(json['hirers']) : null;
    if (json['equip_payment'] != null) {
      _equipPayment = [];
      json['equip_payment'].forEach((v) {
       // _equipPayment?.add(Dynamic.fromJson(v));
      });
    }
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
 // ExtendEquipRequest? _extendEquipRequest;
  Hirers? _hirers;
  List<dynamic>? _equipPayment;
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
  //ExtendEquipRequest? extendEquipRequest,
  Hirers? hirers,
  List<dynamic>? equipPayment,
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
 // extendEquipRequest: extendEquipRequest ?? _extendEquipRequest,
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
 // ExtendEquipRequest? get extendEquipRequest => _extendEquipRequest;
  Hirers? get hirers => _hirers;
  List<dynamic>? get equipPayment => _equipPayment;

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
    // if (_extendEquipRequest != null) {
    //   map['extend_equip_request'] = _extendEquipRequest?.toJson();
    // }
    if (_hirers != null) {
      map['hirers'] = _hirers?.toJson();
    }
    if (_equipPayment != null) {
      map['equip_payment'] = _equipPayment?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "9"
/// fullname : "Holynation developer"
/// email : "holynation667@gmail.com"
/// phone_number : "+2348109994486"
/// gender : ""
/// address : null
/// address_opt : null
/// local_state : null
/// country : null
/// hirers_path : null
/// status : "1"
/// date_modified : "2022-05-09 16:51:27"
/// date_created : "2022-05-06 12:45:43"

class Hirers {
  Hirers({
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
  dynamic _address;
  dynamic _addressOpt;
  dynamic _localState;
  dynamic _country;
  dynamic _hirersPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
Hirers copyWith({  String? id,
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
  dynamic get address => _address;
  dynamic get addressOpt => _addressOpt;
  dynamic get localState => _localState;
  dynamic get country => _country;
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

/// ID : "2"
/// user_id : "holynationdevelopment@gmail.com"
/// owners_id : "11"
/// equip_name : "Bulldozer"
/// equip_images_id : "/var/www/holynation/gig/equipro/writable/uploads/equipments/1651718951_6a63c19020a5fa15229e.png"
/// cost_of_hire : "5000"
/// cost_of_hire_interval : "7"
/// avail_from : "2022-05-05 00:00:00"
/// avail_to : "2022-12-25 00:00:00"
/// quantity : "12"
/// description : "This is a bulldozer useful for farming and item carriage"
/// status : "1"
/// date_modified : "2022-05-26 14:39:24"
/// date_created : "2022-05-05 02:49:11"

class Equipments {
  Equipments({
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
      String? dateCreated,}){
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
}

  Equipments.fromJson(dynamic json) {
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
Equipments copyWith({  String? id,
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
}) => Equipments(  id: id ?? _id,
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
    return map;
  }

}

/// ID : "26"
/// hirers_id : "9"
/// owners_id : "1"
/// order_number : "1000000014"
/// quantity : "3"
/// discount : null
/// total_amount : "2142.86"
/// delivery_charge : "0"
/// order_status : "rejected"
/// order_type : "normal"
/// pickup_date : "2022-05-10 00:00:00"
/// payment_status : "0"
/// date_modified : "2022-05-26 20:04:10"
/// date_created : "2022-05-08 15:21:23"

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
    map['payment_status'] = _paymentStatus;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}