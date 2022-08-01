import 'package:flutter/material.dart';

@immutable
class Signal {
  const Signal({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isExpired = false,
  });

  factory Signal.fromMap(Map<String, dynamic> map) {
    return Signal(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      isExpired: map['isExpired'] as bool,
    );
  }

  final String id;
  final String title;
  final String imageUrl;
  final bool isExpired;

  Signal copyWith({
    required String id,
    required String title,
    required String imageUrl,
    bool isExpired = false,
  }) {
    return Signal(
      id: id,
      title: title,
      imageUrl: imageUrl,
      isExpired: isExpired,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'isExpired': isExpired,
    };
  }
}
