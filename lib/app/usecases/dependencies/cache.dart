
abstract interface class ICache {
  Future<bool> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}