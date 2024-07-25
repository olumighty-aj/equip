import 'package:json_annotation/json_annotation.dart';
import '../delivery_status_lists/delivery_status_lists.dart';
part 'equip_delivery_status.g.dart';

@JsonSerializable()
class EquipDeliveryStatus {
  EquipDeliveryStatus({
    this.delivery_status,
    this.delivery_status_lists,
  });

  String? delivery_status;
  List<DeliveryStatusLists>? delivery_status_lists;

  factory EquipDeliveryStatus.fromJson(Map<String, dynamic> json) =>
      _$EquipDeliveryStatusFromJson(json);

  Map<String, dynamic> toJson() => _$EquipDeliveryStatusToJson(this);
}
