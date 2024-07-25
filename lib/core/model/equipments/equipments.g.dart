// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentModel _$EquipmentModelFromJson(Map<String, dynamic> json) =>
    EquipmentModel(
      id: json['id'] as String?,
      ID: json['ID'] as String?,
      user_id: json['user_id'] as String?,
      owners_id: json['owners_id'] as String?,
      equip_name: json['equip_name'] as String?,
      equip_images_id: json['equip_images_id'] as String?,
      cost_of_hire: json['cost_of_hire'] as String?,
      cost_of_hire_interval: json['cost_of_hire_interval'] as String?,
      avail_from: json['avail_from'] as String?,
      avail_to: json['avail_to'] as String?,
      quantity: json['quantity'] as String?,
      hirers_id: json['hirers_id'] as String?,
      description: json['description'] as String?,
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      status: json['status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
      equip_images: (json['equip_images'] as List<dynamic>?)
          ?.map((e) => EquipImages.fromJson(e as Map<String, dynamic>))
          .toList(),
      equip_request: (json['equip_request'] as List<dynamic>?)
          ?.map((e) => EquipRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      owners: json['owners'] == null
          ? null
          : Owners.fromJson(json['owners'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      average_rating: json['average_rating'] as String?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$EquipmentModelToJson(EquipmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ID': instance.ID,
      'user_id': instance.user_id,
      'owners_id': instance.owners_id,
      'equip_name': instance.equip_name,
      'equip_images_id': instance.equip_images_id,
      'cost_of_hire': instance.cost_of_hire,
      'cost_of_hire_interval': instance.cost_of_hire_interval,
      'avail_from': instance.avail_from,
      'avail_to': instance.avail_to,
      'quantity': instance.quantity,
      'hirers_id': instance.hirers_id,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'status': instance.status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
      'equip_images': instance.equip_images,
      'equip_request': instance.equip_request,
      'owners': instance.owners,
      'reviews': instance.reviews,
      'average_rating': instance.average_rating,
      'currency': instance.currency,
    };
