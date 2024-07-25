// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      id: json['id'] as String?,
      hirers_id: json['hirers_id'] as String?,
      is_owners: json['is_owners'] as String?,
      equipments_id: json['equipments_id'] as String?,
      comment: json['comment'] as String?,
      rating: json['rating'] as String?,
      date_created: json['date_created'] as String?,
      fullname: json['fullname'] as String?,
      hirers_path: json['hirers_path'] as String?,
      hirers: json['hirers'] == null
          ? null
          : Hirers.fromJson(json['hirers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'hirers_id': instance.hirers_id,
      'is_owners': instance.is_owners,
      'equipments_id': instance.equipments_id,
      'comment': instance.comment,
      'rating': instance.rating,
      'date_created': instance.date_created,
      'fullname': instance.fullname,
      'hirers_path': instance.hirers_path,
      'hirers': instance.hirers,
    };
