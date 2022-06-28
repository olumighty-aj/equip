/// ID : "1"
/// sender_id : "8"
/// receiver_id : "9"
/// message : "This is a test on pusher chat message"
/// type : "sent"
/// inbox_id : "1"
/// status : "0"
/// date_modified : "2022-06-23 15:40:02"
/// date_created : "2022-06-23 15:40:02"

class ChatMessages {
  ChatMessages({
      String? id, 
      String? senderId, 
      String? receiverId, 
      String? message, 
      String? type, 
      String? inboxId, 
      String? status, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _senderId = senderId;
    _receiverId = receiverId;
    _message = message;
    _type = type;
    _inboxId = inboxId;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  ChatMessages.fromJson(dynamic json) {
    _id = json['ID'];
    _senderId = json['sender_id'];
    _receiverId = json['receiver_id'];
    _message = json['message'];
    _type = json['type'];
    _inboxId = json['inbox_id'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _senderId;
  String? _receiverId;
  String? _message;
  String? _type;
  String? _inboxId;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
ChatMessages copyWith({  String? id,
  String? senderId,
  String? receiverId,
  String? message,
  String? type,
  String? inboxId,
  String? status,
  String? dateModified,
  String? dateCreated,
}) => ChatMessages(  id: id ?? _id,
  senderId: senderId ?? _senderId,
  receiverId: receiverId ?? _receiverId,
  message: message ?? _message,
  type: type ?? _type,
  inboxId: inboxId ?? _inboxId,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get senderId => _senderId;
  String? get receiverId => _receiverId;
  String? get message => _message;
  String? get type => _type;
  String? get inboxId => _inboxId;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['sender_id'] = _senderId;
    map['receiver_id'] = _receiverId;
    map['message'] = _message;
    map['type'] = _type;
    map['inbox_id'] = _inboxId;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}