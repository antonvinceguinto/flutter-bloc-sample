class User {
  const User({
    required this.id,
    this.name,
    this.email,
    this.avatar,
    this.emailVerified,
  });

  final String id;
  final String? name;
  final String? email;
  final String? avatar;
  final bool? emailVerified;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  List<Object?> get props => [id, name, email, avatar, emailVerified];
}
