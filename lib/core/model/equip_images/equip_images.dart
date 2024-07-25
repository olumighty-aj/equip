import 'package:json_annotation/json_annotation.dart';

part 'equip_images.g.dart';

@JsonSerializable()
class EquipImages {
  EquipImages({
    this.id,
    this.equipments_id,
    this.equip_images_path,
    this.status,
    this.date_modified,
    this.date_created,
  });

  String? id;
  String? equipments_id;
  String? equip_images_path;
  String? status;
  String? date_modified;
  String? date_created;

  factory EquipImages.fromJson(Map<String, dynamic> json) =>
      _$EquipImagesFromJson(json);

  Map<String, dynamic> toJson() => _$EquipImagesToJson(this);
}
