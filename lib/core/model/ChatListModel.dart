/// id : "1"
/// user_id : "8"
/// chat_with_id : "8"
/// message_count : "3"
/// last_message : "This is a test on pusher chat message"
/// date_created : "2022-06-23 15:40:01"
/// date_modified : "2022-06-23 15:46:06"
/// chat_with : {"ID":"8","fullname":"Oluwaseun Alatise","email":"holynationdevelopment@gmail.com","phone_number":"+2348109994485","gender":"male","address":"No 26, Gbemisola street, Allen Avenue, Ikeja","address_opt":null,"local_state":"Oyo","country":"Nigeria","latitude":"2.17403","longitude":"41.4034","hirers_path":null,"status":"1","date_modified":"2022-06-20 19:03:30","date_created":"2022-06-20 16:09:39"}

class ChatListModel {
  ChatListModel({
      String? id, 
      String? userId, 
      String? chatWithId, 
      String? messageCount, 
      String? lastMessage, 
      String? dateCreated, 
      String? dateModified, 
      ChatWith? chatWith,}){
    _id = id;
    _userId = userId;
    _chatWithId = chatWithId;
    _messageCount = messageCount;
    _lastMessage = lastMessage;
    _dateCreated = dateCreated;
    _dateModified = dateModified;
    _chatWith = chatWith;
}

  ChatListModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _chatWithId = json['chat_with_id'];
    _messageCount = json['message_count'];
    _lastMessage = json['last_message'];
    _dateCreated = json['date_created'];
    _dateModified = json['date_modified'];
    _chatWith = json['chat_with'] != null ? ChatWith.fromJson(json['chat_with']) : null;
  }
  String? _id;
  String? _userId;
  String? _chatWithId;
  String? _messageCount;
  String? _lastMessage;
  String? _dateCreated;
  String? _dateModified;
  ChatWith? _chatWith;
ChatListModel copyWith({  String? id,
  String? userId,
  String? chatWithId,
  String? messageCount,
  String? lastMessage,
  String? dateCreated,
  String? dateModified,
  ChatWith? chatWith,
}) => ChatListModel(  id: id ?? _id,
  userId: userId ?? _userId,
  chatWithId: chatWithId ?? _chatWithId,
  messageCount: messageCount ?? _messageCount,
  lastMessage: lastMessage ?? _lastMessage,
  dateCreated: dateCreated ?? _dateCreated,
  dateModified: dateModified ?? _dateModified,
  chatWith: chatWith ?? _chatWith,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get chatWithId => _chatWithId;
  String? get messageCount => _messageCount;
  String? get lastMessage => _lastMessage;
  String? get dateCreated => _dateCreated;
  String? get dateModified => _dateModified;
  ChatWith? get chatWith => _chatWith;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['chat_with_id'] = _chatWithId;
    map['message_count'] = _messageCount;
    map['last_message'] = _lastMessage;
    map['date_created'] = _dateCreated;
    map['date_modified'] = _dateModified;
    if (_chatWith != null) {
      map['chat_with'] = _chatWith?.toJson();
    }
    return map;
  }

}

/// ID : "8"
/// fullname : "Oluwaseun Alatise"
/// email : "holynationdevelopment@gmail.com"
/// phone_number : "+2348109994485"
/// gender : "male"
/// address : "No 26, Gbemisola street, Allen Avenue, Ikeja"
/// address_opt : null
/// local_state : "Oyo"
/// country : "Nigeria"
/// latitude : "2.17403"
/// longitude : "41.4034"
/// hirers_path : null
/// status : "1"
/// date_modified : "2022-06-20 19:03:30"
/// date_created : "2022-06-20 16:09:39"

class ChatWith {
  ChatWith({
      String? id, 
      String? fullname, 
      String? email, 
      String? phoneNumber, 
      String? gender, 
      String? address, 
      dynamic addressOpt, 
      String? localState, 
      String? country, 
      String? latitude, 
      String? longitude, 
      dynamic hirersPath, 
      String? status, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _fullname = fullname;
    _email = email;
    _phoneNumber = phoneNumber;
    _gender = gender;
    _address = address;
    _addressOpt = addressOpt;
    _localState = localState;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _hirersPath = hirersPath;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  ChatWith.fromJson(dynamic json) {
    _id = json['ID'];
    _fullname = json['fullname'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _gender = json['gender'];
    _address = json['address'];
    _addressOpt = json['address_opt'];
    _localState = json['local_state'];
    _country = json['country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _hirersPath = json['hirers_path'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _fullname;
  String? _email;
  String? _phoneNumber;
  String? _gender;
  String? _address;
  dynamic _addressOpt;
  String? _localState;
  String? _country;
  String? _latitude;
  String? _longitude;
  dynamic _hirersPath;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
ChatWith copyWith({  String? id,
  String? fullname,
  String? email,
  String? phoneNumber,
  String? gender,
  String? address,
  dynamic addressOpt,
  String? localState,
  String? country,
  String? latitude,
  String? longitude,
  dynamic hirersPath,
  String? status,
  String? dateModified,
  String? dateCreated,
}) => ChatWith(  id: id ?? _id,
  fullname: fullname ?? _fullname,
  email: email ?? _email,
  phoneNumber: phoneNumber ?? _phoneNumber,
  gender: gender ?? _gender,
  address: address ?? _address,
  addressOpt: addressOpt ?? _addressOpt,
  localState: localState ?? _localState,
  country: country ?? _country,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  hirersPath: hirersPath ?? _hirersPath,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get gender => _gender;
  String? get address => _address;
  dynamic get addressOpt => _addressOpt;
  String? get localState => _localState;
  String? get country => _country;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  dynamic get hirersPath => _hirersPath;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['gender'] = _gender;
    map['address'] = _address;
    map['address_opt'] = _addressOpt;
    map['local_state'] = _localState;
    map['country'] = _country;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['hirers_path'] = _hirersPath;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}