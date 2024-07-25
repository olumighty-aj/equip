import 'package:json_annotation/json_annotation.dart';

part 'equip_order.g.dart';

@JsonSerializable()
class EquipOrder {
  EquipOrder({
    this.id,
    this.hirers_id,
    this.owners_id,
    this.order_number,
    this.quantity,
    this.service_charge,
    this.discount,
    this.total_amount,
    this.delivery_charge,
    this.order_status,
    this.order_type,
    this.pickup_date,
    this.latitude,
    this.longitude,
    this.payment_status,
    this.date_modified,
    this.date_created,
  });

  String? id;
  String? hirers_id;
  String? owners_id;
  String? order_number;
  String? quantity;
  String? service_charge;
  dynamic discount;
  String? total_amount;
  String? delivery_charge;
  String? order_status;
  String? order_type;
  String? pickup_date;
  String? latitude;
  String? longitude;
  String? payment_status;
  String? date_modified;
  String? date_created;

  factory EquipOrder.fromJson(Map<String, dynamic> json) =>
      _$EquipOrderFromJson(json);

  Map<String, dynamic> toJson() => _$EquipOrderToJson(this);
}
