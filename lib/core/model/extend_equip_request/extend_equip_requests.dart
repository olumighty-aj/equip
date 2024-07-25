// class ExtendEquipRequest {
//   ExtendEquipRequest({
//     String? id,
//     String? hirersId,
//     String? equipRequestId,
//     String? equipOrderId,
//     String? prevEquipOrder,
//     String? rentalFrom,
//     String? rentalTo,
//     String? requestStatus,
//     String? dateModified,
//     String? dateCreated,
//   }) {
//     _id = id;
//     _hirersId = hirersId;
//     _equipRequestId = equipRequestId;
//     _equipOrderId = equipOrderId;
//     _prevEquipOrder = prevEquipOrder;
//     _rentalFrom = rentalFrom;
//     _rentalTo = rentalTo;
//     _requestStatus = requestStatus;
//     _dateModified = dateModified;
//     _dateCreated = dateCreated;
//   }
//
//   ExtendEquipRequest.fromJson(dynamic json) {
//     _id = json['ID'];
//     _hirersId = json['hirers_id'];
//     _equipRequestId = json['equip_request_id'];
//     _equipOrderId = json['equip_order_id'];
//     _prevEquipOrder = json['prev_equip_order'];
//     _rentalFrom = json['rental_from'];
//     _rentalTo = json['rental_to'];
//     _requestStatus = json['request_status'];
//     _dateModified = json['date_modified'];
//     _dateCreated = json['date_created'];
//   }
//   String? _id;
//   String? _hirersId;
//   String? _equipRequestId;
//   String? _equipOrderId;
//   String? _prevEquipOrder;
//   String? _rentalFrom;
//   String? _rentalTo;
//   String? _requestStatus;
//   String? _dateModified;
//   String? _dateCreated;
//   ExtendEquipRequest copyWith({
//     String? id,
//     String? hirersId,
//     String? equipRequestId,
//     String? equipOrderId,
//     String? prevEquipOrder,
//     String? rentalFrom,
//     String? rentalTo,
//     String? requestStatus,
//     String? dateModified,
//     String? dateCreated,
//   }) =>
//       ExtendEquipRequest(
//         id: id ?? _id,
//         hirersId: hirersId ?? _hirersId,
//         equipRequestId: equipRequestId ?? _equipRequestId,
//         equipOrderId: equipOrderId ?? _equipOrderId,
//         prevEquipOrder: prevEquipOrder ?? _prevEquipOrder,
//         rentalFrom: rentalFrom ?? _rentalFrom,
//         rentalTo: rentalTo ?? _rentalTo,
//         requestStatus: requestStatus ?? _requestStatus,
//         dateModified: dateModified ?? _dateModified,
//         dateCreated: dateCreated ?? _dateCreated,
//       );
//   String? get id => _id;
//   String? get hirersId => _hirersId;
//   String? get equipRequestId => _equipRequestId;
//   String? get equipOrderId => _equipOrderId;
//   String? get prevEquipOrder => _prevEquipOrder;
//   String? get rentalFrom => _rentalFrom;
//   String? get rentalTo => _rentalTo;
//   String? get requestStatus => _requestStatus;
//   String? get dateModified => _dateModified;
//   String? get dateCreated => _dateCreated;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ID'] = _id;
//     map['hirers_id'] = _hirersId;
//     map['equip_request_id'] = _equipRequestId;
//     map['equip_order_id'] = _equipOrderId;
//     map['prev_equip_order'] = _prevEquipOrder;
//     map['rental_from'] = _rentalFrom;
//     map['rental_to'] = _rentalTo;
//     map['request_status'] = _requestStatus;
//     map['date_modified'] = _dateModified;
//     map['date_created'] = _dateCreated;
//     return map;
//   }
// }

import 'package:json_annotation/json_annotation.dart';

part 'extend_equip_requests.g.dart';

@JsonSerializable()
class ExtendEquipRequest {
  ExtendEquipRequest({
    this.id,
    this.hirers_id,
    this.equip_request_id,
    this.equip_order_id,
    this.prev_equip_order,
    this.rental_from,
    this.rental_to,
    this.request_status,
    this.date_modified,
    this.date_created,
  });

  String? id;
  String? hirers_id;
  String? equip_request_id;
  String? equip_order_id;
  String? prev_equip_order;
  String? rental_from;
  String? rental_to;
  String? request_status;
  String? date_modified;
  String? date_created;

  factory ExtendEquipRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtendEquipRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendEquipRequestToJson(this);
}
