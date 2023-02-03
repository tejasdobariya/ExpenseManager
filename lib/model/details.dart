import 'package:cloud_firestore/cloud_firestore.dart';

class Details {
  late String id;
  late String category;
  late int amount;
  late String note;
  late String type;
  late DateTime selectedDate;
  late String email;
  late String txnid;
  late String account;

  Details(
      {required this.category,
        required this.amount,
        required this.note,
        required this.type,
        required this.selectedDate,
        required this.email,
        required this.txnid,
        required this.id,
      required this.account});

  Map<String, dynamic> toJson() => {
    'categoty': category,
    'amount': amount,
    'note': note,
    'type': type,
    'date': selectedDate,
    'email': email,
    'txnid': txnid,
    'account':account
  };

  static Details fromJson(Map<String, dynamic> json) => Details(
      category: json['category'],
      amount: json['amount'],
      note: json['note'],
      type: json['type'],
      selectedDate: (json['date'] as Timestamp).toDate(),
      email: json['email'],
      txnid: json['txnid'],
      id: json['id'],
      account: json['account']);
}
