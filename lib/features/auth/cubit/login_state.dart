part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  submitting,
  success,
  error,
}

@immutable
class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    required this.error,
  });

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        status: LoginStatus.initial,
        error: '',
      );

  final String email;
  final String password;
  final LoginStatus status;
  final String error;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [email, password, status, error];
}
