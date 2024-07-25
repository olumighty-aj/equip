// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equip_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipImages _$EquipImagesFromJson(Map<String, dynamic> json) => EquipImages(
      id: json['id'] as String?,
      equipments_id: json['equipments_id'] as String?,
      equip_images_path: json['equip_images_path'] as String?,
      status: json['status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
    );

Map<String, dynamic> _$EquipImagesToJson(EquipImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equipments_id': instance.equipments_id,
      'equip_images_path': instance.equip_images_path,
      'status': instance.status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
    };
