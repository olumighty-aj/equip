import 'package:json_annotation/json_annotation.dart';
import '../equip_booking_model.dart';
import '../equip_images/equip_images.dart';
import '../equip_requests/equip_request.dart';
import '../owners/owners.dart';
import '../reviews/reviews.dart';

part 'equipments.g.dart';

@JsonSerializable()
class EquipmentModel {
  EquipmentModel({
    this.id,
    this.ID,
    this.user_id,
    this.owners_id,
    this.equip_name,
    this.equip_images_id,
    this.cost_of_hire,
    this.cost_of_hire_interval,
    this.avail_from,
    this.avail_to,
    this.quantity,
    this.hirers_id,
    this.description,
    this.latitude,
    this.longitude,
    this.address,
    this.status,
    this.date_modified,
    this.date_created,
    this.equip_images,
    this.equip_request,
    this.owners,
    this.reviews,
    this.average_rating,
    this.currency,
  });

  String? id;
  String? ID;
  String? user_id;
  String? owners_id;
  String? equip_name;
  String? equip_images_id;
  String? cost_of_hire;
  String? cost_of_hire_interval;
  String? avail_from;
  String? avail_to;
  String? quantity;
  String? hirers_id;
  String? description;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  String? status;
  String? date_modified;
  String? date_created;
  List<EquipImages>? equip_images;
  List<EquipRequest>? equip_request;
  Owners? owners;
  List<Reviews>? reviews;
  String? average_rating;
  String? currency;

  factory EquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentModelToJson(this);
}
