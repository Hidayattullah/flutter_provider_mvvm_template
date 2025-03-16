
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../dto/auth.dart';
import '../auth.dart';
import '../dependencies/cache.dart';
import '../dependencies/repository_auth.dart';

final log = Logger("AuthenticationService");

class AuthenticationService implements IAuth {
  final ICache _cache;
  final IAuthRepository _authRepository;

  final _authSubject =
      BehaviorSubject<AuthCredentials>.seeded(const AuthNotKnown());

  Stream<AuthCredentials> get authStream => _authSubject.stream.doOnData((AuthCredentials a){
    switch(a) {
      case AuthLoggedIn(): log.fine("loggedin ${a.userId}");
      case AuthNotLoggedIn(): log.finer("not loggedin");
      case AuthNotKnown(): log.finer("not known");
    }
  });

  final _errorSubject = BehaviorSubject<AuthError>();

  Stream<AuthError> get errorStream => _errorSubject.stream.doOnData((e){
    switch(e){
      case AuthErrorMessage(): log.finer("authError: $e");
      case AuthOk(): log.finer("auth ok");
    }
  });

  AuthenticationService(
      {required ICache cache, required IAuthRepository authRepository})
      : _cache = cache,
        _authRepository = authRepository;

  void init() {
    tryAuth();
  }

  @override
  void loginWithPassword(String userName, String password) async {
    _errorSubject.value = const AuthOk();
    try {
      final response = await _authRepository.getAccessToken(
          AccessTokenRequest(userName: userName, password: password));
      final token = response.token;
      _cache.saveToken(token);
      tryAuth();
    } catch (e) {
      _authSubject.value = const AuthNotLoggedIn();
      _errorSubject.value = AuthErrorMessage(message: e.toString());
    }
  }

  @override
  void logout() {
    _errorSubject.value = const AuthOk();
    _authSubject.value = const AuthNotLoggedIn();
    _cache.removeToken();
  }

  @override
  void tryAuth() async {
    _errorSubject.value = const AuthOk();
    try {
      final token = await _cache.getToken();
      if (token == null) {
        _authSubject.value = const AuthNotLoggedIn();
        return;
      }
      final request = TestTokenRequest(token: token);
      final response = await _authRepository.testAccessToken(request);
      _authSubject.value = AuthLoggedIn(userId: response.userId);
    } catch (e) {
      _authSubject.value = const AuthNotLoggedIn();
      _errorSubject.value = AuthErrorMessage(message: e.toString());
    }
  }

  @override
  // TODO: implement credential
  AuthCredentials get credentials => _authSubject.value;

  @override
  // TODO: implement error
  AuthError get error => _errorSubject.value;
}
