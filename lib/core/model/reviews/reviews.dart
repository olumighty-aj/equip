// class Reviews {
//   Reviews({
//     String? id,
//     String? hirersId,
//     String? isOwners,
//     String? equipmentsId,
//     String? comment,
//     String? rating,
//     String? dateCreated,
//     String? fullname,
//     String? hirersPath,
//   }) {
//     _id = id;
//     _hirersId = hirersId;
//     _isOwners = isOwners;
//     _equipmentsId = equipmentsId;
//     _comment = comment;
//     _rating = rating;
//     _dateCreated = dateCreated;
//     _fullname = fullname;
//     _hirersPath = hirersPath;
//   }
//
//   Reviews.fromJson(dynamic json) {
//     _id = json['ID'];
//     _hirersId = json['hirers_id'];
//     _isOwners = json['is_owners'];
//     _equipmentsId = json['equipments_id'];
//     _comment = json['comment'];
//     _rating = json['rating'];
//     _dateCreated = json['date_created'];
//     _fullname = json['fullname'];
//     _hirersPath = json['hirers_path'];
//   }
//   String? _id;
//   String? _hirersId;
//   String? _isOwners;
//   String? _equipmentsId;
//   String? _comment;
//   String? _rating;
//   String? _dateCreated;
//   String? _fullname;
//   String? _hirersPath;
//   Reviews copyWith({
//     String? id,
//     String? hirersId,
//     String? isOwners,
//     String? equipmentsId,
//     String? comment,
//     String? rating,
//     String? dateCreated,
//     String? fullname,
//     String? hirersPath,
//   }) =>
//       Reviews(
//         id: id ?? _id,
//         hirersId: hirersId ?? _hirersId,
//         isOwners: isOwners ?? _isOwners,
//         equipmentsId: equipmentsId ?? _equipmentsId,
//         comment: comment ?? _comment,
//         rating: rating ?? _rating,
//         dateCreated: dateCreated ?? _dateCreated,
//         fullname: fullname ?? _fullname,
//         hirersPath: hirersPath ?? _hirersPath,
//       );
//   String? get id => _id;
//   String? get hirersId => _hirersId;
//   String? get isOwners => _isOwners;
//   String? get equipmentsId => _equipmentsId;
//   String? get comment => _comment;
//   String? get rating => _rating;
//   String? get dateCreated => _dateCreated;
//   String? get fullname => _fullname;
//   String? get hirersPath => _hirersPath;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ID'] = _id;
//     map['hirers_id'] = _hirersId;
//     map['is_owners'] = _isOwners;
//     map['equipments_id'] = _equipmentsId;
//     map['comment'] = _comment;
//     map['rating'] = _rating;
//     map['date_created'] = _dateCreated;
//     map['fullname'] = _fullname;
//     map['hirers_path'] = _hirersPath;
//     return map;
//   }
// }

import 'package:json_annotation/json_annotation.dart';

import '../hirers/hirers.dart';

part 'reviews.g.dart';

@JsonSerializable()
class Reviews {
  String? id;
  String? hirers_id;
  String? is_owners;
  String? equipments_id;
  String? comment;
  String? rating;
  String? date_created;
  String? fullname;
  String? hirers_path;
  Hirers? hirers;

  Reviews(
      {this.id,
      this.hirers_id,
      this.is_owners,
      this.equipments_id,
      this.comment,
      this.rating,
      this.date_created,
      this.fullname,
      this.hirers_path,
      this.hirers});

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}
