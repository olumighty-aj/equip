// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDataModel _$BaseDataModelFromJson(Map<String, dynamic> json) =>
    BaseDataModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      payload: json['payload'],
    );

Map<String, dynamic> _$BaseDataModelToJson(BaseDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'payload': instance.payload,
    };
