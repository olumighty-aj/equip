import 'package:json_annotation/json_annotation.dart';

import '../equip_booking_model.dart';
import '../equip_order/equip_order.dart';
import '../equipments/equipments.dart';
import '../hirers/hirers.dart';

part 'equip_request.g.dart';

@JsonSerializable()
class EquipRequest {
  EquipRequest({
    this.id,
    this.equip_order_id,
    this.hirers_id,
    this.equipments_id,
    this.quantity,
    this.rental_from,
    this.rental_to,
    this.delivery_location,
    this.request_status,
    this.date_modified,
    this.date_created,
    this.equipments,
    this.equip_order,
    this.hirers,
  });

  String? id;
  String? equip_order_id;
  String? hirers_id;
  String? equipments_id;
  String? quantity;
  String? rental_from;
  String? rental_to;
  String? delivery_location;
  String? request_status;
  String? date_modified;
  String? date_created;
  EquipmentModel? equipments;
  EquipOrder? equip_order;
  Hirers? hirers;

  factory EquipRequest.fromJson(Map<String, dynamic> json) =>
      _$EquipRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EquipRequestToJson(this);
}
