import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categories {
  String? email;
  String? uid;
  String? id;
  num? food = 0;
  num? shopping = 0;
  num? medical = 0;
  num? kids = 0;
  num? entertainment = 0;
  num? vehicle = 0;
  num? housing = 0;
  num? groceries = 0;
  num? general = 0;
  num? bills = 0;
  num? investment = 0;
  num? education = 0;

  Categories({
    this.email,
    this.uid,
    this.food,
    this.shopping,
    this.medical,
    this.kids,
    this.entertainment,
    this.vehicle,
    this.housing,
    this.groceries,
    this.general,
    this.bills,
    this.investment,
    this.education,
    this.id,
  });
  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'food': food,
        'shopping': shopping,
        'medical': medical,
        'kids': kids,
        'entertainment': entertainment,
        'vehicle': vehicle,
        'housing': housing,
        'groceries': groceries,
        'general': general,
        'bills': bills,
        'investment': investment,
        'education': education,
        'id':id
      };

  static Categories fromJson(Map<String, dynamic> json) => Categories(
      email: json['email'],
      uid: json['uid'],
      food: json['food'],
      shopping: json['shopping'],
      medical: json['medical'],
      kids: json['kids'],
      entertainment: json['entertainment'],
      vehicle: json['vehicle'],
      housing: json['housing'],
      groceries: json['groceries'],
      general: json['general'],
      bills: json['bills'],
      investment: json['investment'],
      education: json['education'],
    id:json['id']
  );

  factory Categories.fromMap(map) {
    return Categories(
      id: map['id'],
      uid: map['uid'],
      email: map['email'],
      food:map['food'],
      shopping:map['shopping'],
      medical:map['medical'],
      kids:map['kids'],
      entertainment:map['entertainment'],
      vehicle:map['vehicle'],
      housing:map['housing'],
      groceries:map['groceries'],
      general:map['general'],
      bills:map['bills'],
      investment:map['investment'],
      education:map['education'],
    );
  }
}
