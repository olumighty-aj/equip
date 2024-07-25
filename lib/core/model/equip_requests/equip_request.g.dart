// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipRequest _$EquipRequestFromJson(Map<String, dynamic> json) => EquipRequest(
      id: json['id'] as String?,
      equip_order_id: json['equip_order_id'] as String?,
      hirers_id: json['hirers_id'] as String?,
      equipments_id: json['equipments_id'] as String?,
      quantity: json['quantity'] as String?,
      rental_from: json['rental_from'] as String?,
      rental_to: json['rental_to'] as String?,
      delivery_location: json['delivery_location'] as String?,
      request_status: json['request_status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
      equipments: json['equipments'] == null
          ? null
          : EquipmentModel.fromJson(json['equipments'] as Map<String, dynamic>),
      equip_order: json['equip_order'] == null
          ? null
          : EquipOrder.fromJson(json['equip_order'] as Map<String, dynamic>),
      hirers: json['hirers'] == null
          ? null
          : Hirers.fromJson(json['hirers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipRequestToJson(EquipRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equip_order_id': instance.equip_order_id,
      'hirers_id': instance.hirers_id,
      'equipments_id': instance.equipments_id,
      'quantity': instance.quantity,
      'rental_from': instance.rental_from,
      'rental_to': instance.rental_to,
      'delivery_location': instance.delivery_location,
      'request_status': instance.request_status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
      'equipments': instance.equipments,
      'equip_order': instance.equip_order,
      'hirers': instance.hirers,
    };
