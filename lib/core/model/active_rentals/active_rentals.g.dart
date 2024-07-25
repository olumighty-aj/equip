// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_rentals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveRentalsModel _$ActiveRentalsModelFromJson(Map<String, dynamic> json) =>
    ActiveRentalsModel(
      id: json['id'] as String?,
      equip_order_id: json['equip_order_id'] as String?,
      hirers_id: json['hirers_id'] as String?,
      equipments_id: json['equipments_id'] as String?,
      quantity: json['quantity'] as String?,
      rental_from: json['rental_from'] as String?,
      rental_to: json['rental_to'] as String?,
      delivery_location: json['delivery_location'] as String?,
      request_status: json['request_status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
      equip_order: json['equip_order'] == null
          ? null
          : EquipOrder.fromJson(json['equip_order'] as Map<String, dynamic>),
      equipments: json['equipments'] == null
          ? null
          : EquipmentModel.fromJson(json['equipments'] as Map<String, dynamic>),
      extend_equip_request: json['extend_equip_request'] == null
          ? null
          : ExtendEquipRequest.fromJson(
              json['extend_equip_request'] as Map<String, dynamic>),
      equip_delivery_status: json['equip_delivery_status'] == null
          ? null
          : EquipDeliveryStatus.fromJson(
              json['equip_delivery_status'] as Map<String, dynamic>),
      hirers: json['hirers'] == null
          ? null
          : Hirers.fromJson(json['hirers'] as Map<String, dynamic>),
      equip_payment: json['equip_payment'],
      delivery_status_lists: (json['delivery_status_lists'] as List<dynamic>?)
          ?.map((e) => DeliveryStatusLists.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActiveRentalsModelToJson(ActiveRentalsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equip_order_id': instance.equip_order_id,
      'hirers_id': instance.hirers_id,
      'equipments_id': instance.equipments_id,
      'quantity': instance.quantity,
      'rental_from': instance.rental_from,
      'rental_to': instance.rental_to,
      'delivery_location': instance.delivery_location,
      'request_status': instance.request_status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
      'equip_order': instance.equip_order?.toJson(),
      'equipments': instance.equipments?.toJson(),
      'extend_equip_request': instance.extend_equip_request?.toJson(),
      'equip_delivery_status': instance.equip_delivery_status?.toJson(),
      'delivery_status_lists':
          instance.delivery_status_lists?.map((e) => e.toJson()).toList(),
      'hirers': instance.hirers?.toJson(),
      'equip_payment': instance.equip_payment,
    };
