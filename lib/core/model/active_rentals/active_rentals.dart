import 'package:equipro/core/model/delivery_status_lists/delivery_status_lists.dart';
import 'package:json_annotation/json_annotation.dart';

import '../equip_booking_model.dart';
import '../equip_delivery_status/equip_delivery_status.dart';
import '../equip_order/equip_order.dart';
import '../equipments/equipments.dart';
import '../extend_equip_request/extend_equip_requests.dart';
import '../hirers/hirers.dart';

part 'active_rentals.g.dart';

@JsonSerializable(explicitToJson: true)
class ActiveRentalsModel {
  ActiveRentalsModel(
      {this.id,
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
      this.equip_order,
      this.equipments,
      this.extend_equip_request,
      this.equip_delivery_status,
      this.hirers,
      this.equip_payment,
      this.delivery_status_lists});

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
  EquipOrder? equip_order;
  EquipmentModel? equipments;
  ExtendEquipRequest? extend_equip_request;
  EquipDeliveryStatus? equip_delivery_status;
  List<DeliveryStatusLists>? delivery_status_lists;
  Hirers? hirers;
  dynamic equip_payment;

  factory ActiveRentalsModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveRentalsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveRentalsModelToJson(this);
}
