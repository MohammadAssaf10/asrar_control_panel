part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginButtonPressed extends AuthenticationEvent {
  final LoginRequest loginRequest;

  const LoginButtonPressed(this.loginRequest);

  @override
  List<Object?> get props => [loginRequest];
}


