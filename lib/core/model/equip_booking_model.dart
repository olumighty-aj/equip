import 'package:json_annotation/json_annotation.dart';

part 'equip_booking_model.g.dart';

@JsonSerializable()
class EquipImages {
  int? ID;
  int? equipments_id;
  String? equip_images_path;
  int? status;
  String? date_modified;
  String? date_created;

  EquipImages({
    this.ID,
    this.equipments_id,
    this.equip_images_path,
    this.status,
    this.date_modified,
    this.date_created,
  });

  factory EquipImages.fromJson(Map<String, dynamic> json) =>
      _$EquipImagesFromJson(json);

  Map<String, dynamic> toJson() => _$EquipImagesToJson(this);
}

@JsonSerializable()
class Equipments {
  int? ID;
  String? user_id;
  int? owners_id;
  String? equip_name;
  int? cost_of_hire;
  int? cost_of_hire_interval;
  String? avail_from;
  String? avail_to;
  int? quantity;
  String? description;
  double? latitude;
  double? longitude;
  String? address;
  int? status;
  String? date_modified;
  String? date_created;
  List<EquipImages>? equip_images;

  Equipments({
    this.ID,
    this.user_id,
    this.owners_id,
    this.equip_name,
    this.cost_of_hire,
    this.cost_of_hire_interval,
    this.avail_from,
    this.avail_to,
    this.quantity,
    this.description,
    this.latitude,
    this.longitude,
    this.address,
    this.status,
    this.date_modified,
    this.date_created,
    this.equip_images,
  });

  factory Equipments.fromJson(Map<String, dynamic> json) =>
      _$EquipmentsFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentsToJson(this);
}

@JsonSerializable()
class Hirers {
  int? ID;
  String? fullname;
  String? email;
  String? phone_number;
  String? gender;
  String? address;
  String? address_opt;
  String? local_state;
  String? country;
  double? latitude;
  double? longitude;
  String? hirers_path;
  int? status;
  String? date_modified;
  String? date_created;

  Hirers({
    this.ID,
    this.fullname,
    this.email,
    this.phone_number,
    this.gender,
    this.address,
    this.address_opt,
    this.local_state,
    this.country,
    this.latitude,
    this.longitude,
    this.hirers_path,
    this.status,
    this.date_modified,
    this.date_created,
  });

  factory Hirers.fromJson(Map<String, dynamic> json) => _$HirersFromJson(json);

  Map<String, dynamic> toJson() => _$HirersToJson(this);
}

@JsonSerializable()
class EquipDeliveryStatus {
  String? delivery_status;
  List<dynamic>? delivery_status_lists;

  EquipDeliveryStatus({
    this.delivery_status,
    this.delivery_status_lists,
  });

  factory EquipDeliveryStatus.fromJson(Map<String, dynamic> json) =>
      _$EquipDeliveryStatusFromJson(json);

  Map<String, dynamic> toJson() => _$EquipDeliveryStatusToJson(this);
}

@JsonSerializable()
class EquipRequest {
  dynamic ID;
  int? equip_order_id;
  dynamic hirers_id;
  int? equipments_id;
  dynamic quantity;
  String? rental_from;
  String? rental_to;
  String? delivery_location;
  String? request_status;
  String? date_modified;
  String? date_created;
  Equipments? equipments;
  dynamic extend_equip_request;
  EquipDeliveryStatus? equip_delivery_status;
  Hirers? hirers;
  dynamic? equip_payment;

  EquipRequest({
    this.ID,
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
    this.extend_equip_request,
    this.equip_delivery_status,
    this.hirers,
    this.equip_payment,
  });

  factory EquipRequest.fromJson(Map<String, dynamic> json) =>
      _$EquipRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EquipRequestToJson(this);
}

@JsonSerializable()
class OrderModel {
  int? ID;
  int? hirers_id;
  int? owners_id;
  int? order_number;
  int? quantity;
  dynamic? discount;
  int? total_amount;
  int? service_charge;
  String? order_status;
  String? order_type;
  dynamic? pickup_date;
  double? latitude;
  double? longitude;
  dynamic? ip_address;
  dynamic? user_agent;
  dynamic? mac_address;
  int? payment_status;
  String? date_modified;
  String? date_created;
  List<EquipRequest>? equip_request;

  OrderModel({
    this.ID,
    this.hirers_id,
    this.owners_id,
    this.order_number,
    this.quantity,
    this.discount,
    this.total_amount,
    this.service_charge,
    this.order_status,
    this.order_type,
    this.pickup_date,
    this.latitude,
    this.longitude,
    this.ip_address,
    this.user_agent,
    this.mac_address,
    this.payment_status,
    this.date_modified,
    this.date_created,
    this.equip_request,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
