import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../dto/auth.dart';
import '../usecases/dependencies/repository_auth.dart';

class AuthHttpRepository implements IAuthRepository {
  @override
  Future<AccessTokenResponse> getAccessToken(
      AccessTokenRequest request) async {

    final uri = Uri.https(_urlApiAuthority, _urlApiLoginAccessToken);

    final response = await http.post(uri,
      body: {
      'grant_type': 'password',
      'username': request.userName,
      'password': request.password,
      'scope': '',
      'client_id': 'string',
      'client_secret': 'string'
      },
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);

      final token = responseJson['access_token'];
      if (token == null) {
        // TODO: error class?
        throw "No token";
      }
      return AccessTokenResponse( token: token);
    } else {
      final msg = ' ${response.statusCode} ${response.reasonPhrase ?? ""}';
      // TODO: error class?
      throw msg;
    }
  }

  @override
  Future<TestTokenResponse> testAccessToken(TestTokenRequest request) async {
    final uri = Uri.https(_urlApiAuthority, _urlApiTestAccessToken);
    final token = request.token;
    final response = await http.post(uri,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);

      final isActive = responseJson['is_active'] ?? false;
      if (!isActive) {
        // TODO: improve error
        throw "Is not active";
      }
      final userId = responseJson['id'];
      if (userId  == null) {
        // TODO: improve error
        throw "No id";
      }
      return TestTokenResponse( userId: userId);
    } else {
      final msg = ' ${response.statusCode} ${response.reasonPhrase ?? ""}';
      // TODO: error class?
      throw msg;
    }
  }
}

const String _urlApiAuthority = 'api.dev.studyninja.ru';
const String _urlApiBase = '/api/v1';
const String _urlApiLoginBase = '$_urlApiBase/login';
const String _urlApiLoginAccessToken = '$_urlApiLoginBase/access-token';
const String _urlApiTestAccessToken = '$_urlApiLoginBase/test-token';
