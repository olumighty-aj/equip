import 'package:json_annotation/json_annotation.dart';

part 'chat_with.g.dart';

@JsonSerializable()
class ChatWith {
  String? id;
  String? fullname;
  String? email;
  String? phone_number;
  String? gender;
  String? address;
  dynamic address_opt;
  String? local_state;
  String? country;
  String? latitude;
  String? longitude;
  dynamic hirers_path;
  String? status;
  String? date_modified;
  String? date_created;

  ChatWith({
    this.id,
    this.fullname,
    this.email,
    this.phone_number,
    this.gender,
    this.address,
    this.address_opt,
    this.local_state,
    this.country,
    this.latitude,
    this.longitude,
    this.hirers_path,
    this.status,
    this.date_modified,
    this.date_created,
  });

  factory ChatWith.fromJson(Map<String, dynamic> json) =>
      _$ChatWithFromJson(json);

  Map<String, dynamic> toJson() => _$ChatWithToJson(this);
}
