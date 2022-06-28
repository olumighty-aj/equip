/// total_earnings : 0
/// total_withdrawal : 0
/// balance_amount : 0
/// transaction_history : [{"ID":"1","receipt_hash":"1000000011","user_id":"11","owners_id":"1","amount":"5000","status":"0","date_modified":"2022-05-26 21:03:13","date_created":"2022-05-26 21:03:13"}]
/// equip_payment : []

class TransactionModel {
  TransactionModel({
      int? totalEarnings, 
      int? totalWithdrawal, 
      int? balanceAmount, 
      List<TransactionHistory>? transactionHistory, 
      List<dynamic>? equipPayment,}){
    _totalEarnings = totalEarnings;
    _totalWithdrawal = totalWithdrawal;
    _balanceAmount = balanceAmount;
    _transactionHistory = transactionHistory;
    _equipPayment = equipPayment;
}

  TransactionModel.fromJson(dynamic json) {
    _totalEarnings = json['total_earnings'];
    _totalWithdrawal = json['total_withdrawal'];
    _balanceAmount = json['balance_amount'];
    if (json['transaction_history'] != null) {
      _transactionHistory = [];
      json['transaction_history'].forEach((v) {
        _transactionHistory?.add(TransactionHistory.fromJson(v));
      });
    }
    if (json['equip_payment'] != null) {
      _equipPayment = [];
      json['equip_payment'].forEach((v) {
       // _equipPayment?.add(Dynamic.fromJson(v));
      });
    }
  }
  int? _totalEarnings;
  int? _totalWithdrawal;
  int? _balanceAmount;
  List<TransactionHistory>? _transactionHistory;
  List<dynamic>? _equipPayment;
TransactionModel copyWith({  int? totalEarnings,
  int? totalWithdrawal,
  int? balanceAmount,
  List<TransactionHistory>? transactionHistory,
  List<dynamic>? equipPayment,
}) => TransactionModel(  totalEarnings: totalEarnings ?? _totalEarnings,
  totalWithdrawal: totalWithdrawal ?? _totalWithdrawal,
  balanceAmount: balanceAmount ?? _balanceAmount,
  transactionHistory: transactionHistory ?? _transactionHistory,
  equipPayment: equipPayment ?? _equipPayment,
);
  int? get totalEarnings => _totalEarnings;
  int? get totalWithdrawal => _totalWithdrawal;
  int? get balanceAmount => _balanceAmount;
  List<TransactionHistory>? get transactionHistory => _transactionHistory;
  List<dynamic>? get equipPayment => _equipPayment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_earnings'] = _totalEarnings;
    map['total_withdrawal'] = _totalWithdrawal;
    map['balance_amount'] = _balanceAmount;
    if (_transactionHistory != null) {
      map['transaction_history'] = _transactionHistory?.map((v) => v.toJson()).toList();
    }
    if (_equipPayment != null) {
      map['equip_payment'] = _equipPayment?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "1"
/// receipt_hash : "1000000011"
/// user_id : "11"
/// owners_id : "1"
/// amount : "5000"
/// status : "0"
/// date_modified : "2022-05-26 21:03:13"
/// date_created : "2022-05-26 21:03:13"

class TransactionHistory {
  TransactionHistory({
      String? id, 
      String? receiptHash, 
      String? userId, 
      String? ownersId, 
      String? amount, 
      String? status, 
      String? dateModified, 
      String? dateCreated,}){
    _id = id;
    _receiptHash = receiptHash;
    _userId = userId;
    _ownersId = ownersId;
    _amount = amount;
    _status = status;
    _dateModified = dateModified;
    _dateCreated = dateCreated;
}

  TransactionHistory.fromJson(dynamic json) {
    _id = json['ID'];
    _receiptHash = json['receipt_hash'];
    _userId = json['user_id'];
    _ownersId = json['owners_id'];
    _amount = json['amount'];
    _status = json['status'];
    _dateModified = json['date_modified'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _receiptHash;
  String? _userId;
  String? _ownersId;
  String? _amount;
  String? _status;
  String? _dateModified;
  String? _dateCreated;
TransactionHistory copyWith({  String? id,
  String? receiptHash,
  String? userId,
  String? ownersId,
  String? amount,
  String? status,
  String? dateModified,
  String? dateCreated,
}) => TransactionHistory(  id: id ?? _id,
  receiptHash: receiptHash ?? _receiptHash,
  userId: userId ?? _userId,
  ownersId: ownersId ?? _ownersId,
  amount: amount ?? _amount,
  status: status ?? _status,
  dateModified: dateModified ?? _dateModified,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get receiptHash => _receiptHash;
  String? get userId => _userId;
  String? get ownersId => _ownersId;
  String? get amount => _amount;
  String? get status => _status;
  String? get dateModified => _dateModified;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['receipt_hash'] = _receiptHash;
    map['user_id'] = _userId;
    map['owners_id'] = _ownersId;
    map['amount'] = _amount;
    map['status'] = _status;
    map['date_modified'] = _dateModified;
    map['date_created'] = _dateCreated;
    return map;
  }

}