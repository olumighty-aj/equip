/// equipments_id : "1"
/// quantity : "1"
/// rental_from : "2022-05-04"
/// rental_to : "2022-05-08"
/// delivery_location : "No 10, Kwara road, Ibadan"

class BookModel {
  BookModel({
      String? equipmentsId, 
      String? quantity, 
      String? rentalFrom, 
      String? rentalTo,
    String? latitude,
    String? longitude,
    String? deliveryLocation,}){
    _equipmentsId = equipmentsId;
    _quantity = quantity;
    _rentalFrom = rentalFrom;
    _rentalTo = rentalTo;
    _latitude = latitude;
    _longitude = longitude;
    _deliveryLocation = deliveryLocation;
}

  BookModel.fromJson(dynamic json) {
    _equipmentsId = json['equipments_id'];
    _quantity = json['quantity'];
    _rentalFrom = json['rental_from'];
    _rentalTo = json['rental_to'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deliveryLocation = json['delivery_location'];
  }
  String? _equipmentsId;
  String? _quantity;
  String? _rentalFrom;
  String? _rentalTo;
  String? _latitude;
  String? _longitude;
  String? _deliveryLocation;
BookModel copyWith({  String? equipmentsId,
  String? quantity,
  String? rentalFrom,
  String? rentalTo,
  String? latitude,
  String? longitude,
  String? deliveryLocation,
}) => BookModel(  equipmentsId: equipmentsId ?? _equipmentsId,
  quantity: quantity ?? _quantity,
  rentalFrom: rentalFrom ?? _rentalFrom,
  rentalTo: rentalTo ?? _rentalTo,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  deliveryLocation: deliveryLocation ?? _deliveryLocation,
);
  String? get equipmentsId => _equipmentsId;
  String? get quantity => _quantity;
  String? get rentalFrom => _rentalFrom;
  String? get rentalTo => _rentalTo;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get deliveryLocation => _deliveryLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['equipments_id'] = _equipmentsId;
    map['quantity'] = _quantity;
    map['rental_from'] = _rentalFrom;
    map['rental_to'] = _rentalTo;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['delivery_location'] = _deliveryLocation;
    return map;
  }

}