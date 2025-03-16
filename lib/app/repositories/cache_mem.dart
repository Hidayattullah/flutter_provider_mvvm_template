
import '../usecases/dependencies/cache.dart';

const _latency = Duration(milliseconds: 200);

class CacheMemRepository implements ICache {
  final _mem = <String, String>{};

  @override
  Future<bool> saveToken(String token) {
    _mem[CacheManagerKey.token.toString()] = token;
    return Future.delayed(_latency);
  }

  @override
  Future<String?> getToken() async {
    await Future.delayed(_latency);
    return _mem[CacheManagerKey.token.toString()];
  }

  @override
  Future<void> removeToken() async {
    await Future.delayed(_latency);
    _mem.remove(CacheManagerKey.token.toString());
  }
}

enum CacheManagerKey { token }