// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_equip_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendEquipRequest _$ExtendEquipRequestFromJson(Map<String, dynamic> json) =>
    ExtendEquipRequest(
      id: json['id'] as String?,
      hirers_id: json['hirers_id'] as String?,
      equip_request_id: json['equip_request_id'] as String?,
      equip_order_id: json['equip_order_id'] as String?,
      prev_equip_order: json['prev_equip_order'] as String?,
      rental_from: json['rental_from'] as String?,
      rental_to: json['rental_to'] as String?,
      request_status: json['request_status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
    );

Map<String, dynamic> _$ExtendEquipRequestToJson(ExtendEquipRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hirers_id': instance.hirers_id,
      'equip_request_id': instance.equip_request_id,
      'equip_order_id': instance.equip_order_id,
      'prev_equip_order': instance.prev_equip_order,
      'rental_from': instance.rental_from,
      'rental_to': instance.rental_to,
      'request_status': instance.request_status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
    };
