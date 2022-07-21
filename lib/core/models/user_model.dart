class User {
  const User({
    required this.id,
    this.name,
    this.email,
    this.avatar,
  });

  final String id;
  final String? name;
  final String? email;
  final String? avatar;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, email, avatar];
}
