// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hirers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hirers _$HirersFromJson(Map<String, dynamic> json) => Hirers(
      id: json['id'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      phone_number: json['phone_number'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      address_opt: json['address_opt'],
      local_state: json['local_state'] as String?,
      country: json['country'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      hirers_path: json['hirers_path'],
      status: json['status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
    );

Map<String, dynamic> _$HirersToJson(Hirers instance) => <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'phone_number': instance.phone_number,
      'gender': instance.gender,
      'address': instance.address,
      'address_opt': instance.address_opt,
      'local_state': instance.local_state,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'hirers_path': instance.hirers_path,
      'status': instance.status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
    };
