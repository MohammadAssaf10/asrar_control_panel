part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final Employee employee;

  const AuthenticationSuccess({
    required this.employee,
  });

  @override
  List<Object?> get props => [employee];
}

class AuthenticationInProgress extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordRequestSuccess extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed(this.message);

  @override
  List<Object?> get props => [message];
}
