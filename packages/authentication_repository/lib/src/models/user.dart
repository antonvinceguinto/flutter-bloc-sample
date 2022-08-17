import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
@immutable
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.emailVerified,
    this.updatedAt,
    this.createdAt,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// The current user's phone number.
  final bool? emailVerified;

  final String? updatedAt;
  final String? createdAt;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// From map
  /// [map] is a map containing the data of the user.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: '',
      email: map['email'] as String?,
      name: map['name'] as String?,
      photo: map['photo'] as String?,
      emailVerified: map['emailVerified'] as bool?,
      updatedAt: map['updatedAt'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  /// ToMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
      'emailVerified': emailVerified,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  /// CopyWith
  User copyWith({
    String? email,
    String? name,
    String? photo,
    bool? emailVerified,
    String? updatedAt,
    String? createdAt,
  }) =>
      User(
        id: id,
        email: email ?? this.email,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        emailVerified: emailVerified ?? this.emailVerified,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photo,
        emailVerified,
        updatedAt,
        createdAt,
      ];
}
