import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthCredentials{
  const AuthCredentials();
}

@immutable
class AuthNotKnown extends AuthCredentials {
  const AuthNotKnown();
}

@immutable
class AuthNotLoggedIn extends AuthCredentials {
  const AuthNotLoggedIn();
}

@immutable
class AuthLoggedIn extends AuthCredentials {
  final String userId;
  const AuthLoggedIn({required this.userId});

  @override
  String toString() {
    return "Instance of 'AuthLoggedIn': userId=$userId";
  }
}

@immutable
sealed class AuthError {
  const AuthError();
}

@immutable
class AuthOk extends AuthError{
  const AuthOk();
}

@immutable
class AuthErrorMessage extends AuthError{
  final String message;
  const AuthErrorMessage({required this.message});
  @override
  String toString() {
    return "Instance of 'AuthErrorMessage': message=$message";
  }
}

abstract interface class IAuth {
  // TODO: probably they should return future
  //       currently discard the results for simplicity
  void tryAuth();
  void loginWithPassword(String username, String password);
  void logout();
  AuthCredentials get credentials;
  AuthError get error;
}
