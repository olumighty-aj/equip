import 'package:json_annotation/json_annotation.dart';

part 'delivery_status_lists.g.dart';

@JsonSerializable()
class DeliveryStatusLists {
  DeliveryStatusLists({
    this.id,
    this.delivery_status,
    this.date_modified,
    this.date_created,
  });

  String? id;
  String? delivery_status;
  String? date_modified;
  String? date_created;

  factory DeliveryStatusLists.fromJson(Map<String, dynamic> json) =>
      _$DeliveryStatusListsFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryStatusListsToJson(this);
}
