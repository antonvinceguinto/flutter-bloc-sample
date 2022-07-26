import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Signal {
  const Signal({
    required this.id,
    required this.title,
    required this.details,
    required this.type,
    required this.imageUrl,
    required this.timestamp,
    required this.price,
    required this.buyPrice,
    required this.takeProfit,
    required this.stopLoss,
    this.isExpired = false,
  });

  factory Signal.fromMap(Map<String, dynamic> map) {
    return Signal(
      id: map['id'] as String,
      details: map['details'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      isExpired: map['isExpired'] as bool,
      timestamp: map['timestamp'] as Timestamp,
      price: map['price'] as int,
      type: map['type'] as String,
      buyPrice: map['buyPrice'] as int,
      takeProfit: map['takeProfit'] as int,
      stopLoss: map['stopLoss'] as int,
    );
  }

  final String id;
  final String title;
  final String imageUrl;
  final String details;
  final String type;
  final Timestamp timestamp;
  final bool isExpired;
  final int price;
  final int buyPrice;
  final int takeProfit;
  final int stopLoss;

  Signal copyWith({
    required String id,
    required String details,
    required String title,
    required String imageUrl,
    required String type,
    required Timestamp timestamp,
    required int price,
    required int buyPrice,
    required int takeProfit,
    required int stopLoss,
    bool isExpired = false,
  }) {
    return Signal(
      id: id,
      details: details,
      title: title,
      type: type,
      imageUrl: imageUrl,
      timestamp: timestamp,
      price: price,
      isExpired: isExpired,
      buyPrice: buyPrice,
      takeProfit: takeProfit,
      stopLoss: stopLoss,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'details': details,
      'title': title,
      'type': type,
      'imageUrl': imageUrl,
      'isExpired': isExpired,
      'timestamp': timestamp,
      'price': price,
      'buyPrice': buyPrice,
      'takeProfit': takeProfit,
      'stopLoss': stopLoss,
    };
  }
}
