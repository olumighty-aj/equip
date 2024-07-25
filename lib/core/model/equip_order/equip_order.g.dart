// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equip_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipOrder _$EquipOrderFromJson(Map<String, dynamic> json) => EquipOrder(
      id: json['id'] as String?,
      hirers_id: json['hirers_id'] as String?,
      owners_id: json['owners_id'] as String?,
      order_number: json['order_number'] as String?,
      quantity: json['quantity'] as String?,
      service_charge: json['service_charge'] as String?,
      discount: json['discount'],
      total_amount: json['total_amount'] as String?,
      delivery_charge: json['delivery_charge'] as String?,
      order_status: json['order_status'] as String?,
      order_type: json['order_type'] as String?,
      pickup_date: json['pickup_date'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      payment_status: json['payment_status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
    );

Map<String, dynamic> _$EquipOrderToJson(EquipOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hirers_id': instance.hirers_id,
      'owners_id': instance.owners_id,
      'order_number': instance.order_number,
      'quantity': instance.quantity,
      'service_charge': instance.service_charge,
      'discount': instance.discount,
      'total_amount': instance.total_amount,
      'delivery_charge': instance.delivery_charge,
      'order_status': instance.order_status,
      'order_type': instance.order_type,
      'pickup_date': instance.pickup_date,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'payment_status': instance.payment_status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
    };
