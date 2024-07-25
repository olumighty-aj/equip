// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_status_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryStatusLists _$DeliveryStatusListsFromJson(Map<String, dynamic> json) =>
    DeliveryStatusLists(
      id: json['id'] as String?,
      delivery_status: json['delivery_status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
    );

Map<String, dynamic> _$DeliveryStatusListsToJson(
        DeliveryStatusLists instance) =>
    <String, dynamic>{
      'id': instance.id,
      'delivery_status': instance.delivery_status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
    };
