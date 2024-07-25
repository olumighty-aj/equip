// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      equipments_id: json['equipments_id'] as String?,
      quantity: json['quantity'] as String?,
      rental_from: json['rental_from'] as String?,
      rental_to: json['rental_to'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      delivery_location: json['delivery_location'] as String?,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'equipments_id': instance.equipments_id,
      'quantity': instance.quantity,
      'rental_from': instance.rental_from,
      'rental_to': instance.rental_to,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'delivery_location': instance.delivery_location,
    };
