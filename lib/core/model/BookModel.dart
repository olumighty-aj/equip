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
      String? deliveryLocation,}){
    _equipmentsId = equipmentsId;
    _quantity = quantity;
    _rentalFrom = rentalFrom;
    _rentalTo = rentalTo;
    _deliveryLocation = deliveryLocation;
}

  BookModel.fromJson(dynamic json) {
    _equipmentsId = json['equipments_id'];
    _quantity = json['quantity'];
    _rentalFrom = json['rental_from'];
    _rentalTo = json['rental_to'];
    _deliveryLocation = json['delivery_location'];
  }
  String? _equipmentsId;
  String? _quantity;
  String? _rentalFrom;
  String? _rentalTo;
  String? _deliveryLocation;
BookModel copyWith({  String? equipmentsId,
  String? quantity,
  String? rentalFrom,
  String? rentalTo,
  String? deliveryLocation,
}) => BookModel(  equipmentsId: equipmentsId ?? _equipmentsId,
  quantity: quantity ?? _quantity,
  rentalFrom: rentalFrom ?? _rentalFrom,
  rentalTo: rentalTo ?? _rentalTo,
  deliveryLocation: deliveryLocation ?? _deliveryLocation,
);
  String? get equipmentsId => _equipmentsId;
  String? get quantity => _quantity;
  String? get rentalFrom => _rentalFrom;
  String? get rentalTo => _rentalTo;
  String? get deliveryLocation => _deliveryLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['equipments_id'] = _equipmentsId;
    map['quantity'] = _quantity;
    map['rental_from'] = _rentalFrom;
    map['rental_to'] = _rentalTo;
    map['delivery_location'] = _deliveryLocation;
    return map;
  }

}