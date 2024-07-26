// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) =>
    ChatListModel(
      id: json['ID'] as String?,
      user_id: json['user_id'] as String?,
      chat_with_id: json['chat_with_id'] as String?,
      message_count: json['message_count'] as String?,
      last_message: json['last_message'] as String?,
      date_created: json['date_created'] as String?,
      date_modified: json['date_modified'] as String?,
      chat_with: json['chat_with'] == null
          ? null
          : ChatWith.fromJson(json['chat_with'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatListModelToJson(ChatListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'chat_with_id': instance.chat_with_id,
      'message_count': instance.message_count,
      'last_message': instance.last_message,
      'date_created': instance.date_created,
      'date_modified': instance.date_modified,
      'chat_with': instance.chat_with,
    };
