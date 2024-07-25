// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessages _$ChatMessagesFromJson(Map<String, dynamic> json) => ChatMessages(
      id: json['id'] as String?,
      sender_id: json['sender_id'] as String?,
      receiver_id: json['receiver_id'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      inbox_id: json['inbox_id'] as String?,
      status: json['status'] as String?,
      date_modified: json['date_modified'] as String?,
      date_created: json['date_created'] as String?,
    );

Map<String, dynamic> _$ChatMessagesToJson(ChatMessages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.sender_id,
      'receiver_id': instance.receiver_id,
      'message': instance.message,
      'type': instance.type,
      'inbox_id': instance.inbox_id,
      'status': instance.status,
      'date_modified': instance.date_modified,
      'date_created': instance.date_created,
    };
