class NotificationModel {
  NotificationModel({
      String? id, 
      String? entityType, 
      String? entityId, 
      String? notifierId, 
      String? status, 
      String? dateCreated, 
      String? message,}){
    _id = id;
    _entityType = entityType;
    _entityId = entityId;
    _notifierId = notifierId;
    _status = status;
    _dateCreated = dateCreated;
    _message = message;
}

  NotificationModel.fromJson(dynamic json) {
    _id = json['ID'];
    _entityType = json['entity_type'];
    _entityId = json['entity_id'];
    _notifierId = json['notifier_id'];
    _status = json['status'];
    _dateCreated = json['date_created'];
    _message = json['message'];
  }
  String? _id;
  String? _entityType;
  String? _entityId;
  String? _notifierId;
  String? _status;
  String? _dateCreated;
  String? _message;

  String? get id => _id;
  String? get entityType => _entityType;
  String? get entityId => _entityId;
  String? get notifierId => _notifierId;
  String? get status => _status;
  String? get dateCreated => _dateCreated;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['entity_type'] = _entityType;
    map['entity_id'] = _entityId;
    map['notifier_id'] = _notifierId;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    map['message'] = _message;
    return map;
  }

}