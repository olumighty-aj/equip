// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equip_delivery_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipDeliveryStatus _$EquipDeliveryStatusFromJson(Map<String, dynamic> json) =>
    EquipDeliveryStatus(
      delivery_status: json['delivery_status'] as String?,
      delivery_status_lists: (json['delivery_status_lists'] as List<dynamic>?)
          ?.map((e) => DeliveryStatusLists.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquipDeliveryStatusToJson(
        EquipDeliveryStatus instance) =>
    <String, dynamic>{
      'delivery_status': instance.delivery_status,
      'delivery_status_lists': instance.delivery_status_lists,
    };
