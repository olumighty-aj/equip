import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseDataModel {
  bool? status;
  String? message;
  dynamic payload;
  BaseDataModel({this.status, this.message, this.payload});

  factory BaseDataModel.fromJson(Map<String, dynamic> json) =>
      _$BaseDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseDataModelToJson(this);
}
