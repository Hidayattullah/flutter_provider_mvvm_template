import 'package:flutter/cupertino.dart';

@immutable
class AccessTokenRequest {
  final String userName;
  final String password;

  const AccessTokenRequest({required this.userName, required this.password});
}

@immutable
class AccessTokenResponse {
  final String token;

  const AccessTokenResponse({required this.token});
}

@immutable
class TestTokenRequest {
  final String token;

  const TestTokenRequest({required this.token});
}

@immutable
class TestTokenResponse {
  final String userId;

  const TestTokenResponse({required this.userId});
}