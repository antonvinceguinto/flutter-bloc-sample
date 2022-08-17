import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Signal {
  const Signal({
    required this.id,
    required this.title,
    required this.details,
    required this.imageUrl,
    required this.timestamp,
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
    );
  }

  final String id;
  final String title;
  final String imageUrl;
  final String details;
  final Timestamp timestamp;
  final bool isExpired;

  Signal copyWith({
    required String id,
    required String title,
    required String imageUrl,
    bool isExpired = false,
  }) {
    return Signal(
      id: id,
      details: details,
      title: title,
      imageUrl: imageUrl,
      isExpired: isExpired,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'details': details,
      'title': title,
      'imageUrl': imageUrl,
      'isExpired': isExpired,
      'timestamp': timestamp,
    };
  }
}
