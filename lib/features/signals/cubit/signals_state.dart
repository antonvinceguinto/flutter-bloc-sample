part of 'signals_cubit.dart';

class SignalsState extends Equatable {
  const SignalsState({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isExpired,
  });

  final String id;
  final String title;
  final String imageUrl;
  final bool isExpired;

  @override
  List<Object> get props => [id, title, imageUrl, isExpired];
}
