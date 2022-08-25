part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String? displayName;
  final String? uid;
  const AuthenticationSuccess({this.displayName, this.uid});

  @override
  List<Object?> get props => [displayName];
}

class AuthenticationFailure extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
