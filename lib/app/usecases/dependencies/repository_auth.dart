import '../../dto/auth.dart';

abstract interface class IAuthRepository {
  Future<AccessTokenResponse> getAccessToken(AccessTokenRequest request);
  Future<TestTokenResponse> testAccessToken(TestTokenRequest request);
}