import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  String? equipments_id;
  String? quantity;
  String? rental_from;
  String? rental_to;
  String? latitude;
  String? longitude;
  String? delivery_location;

  BookModel({
    this.equipments_id,
    this.quantity,
    this.rental_from,
    this.rental_to,
    this.latitude,
    this.longitude,
    this.delivery_location,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
