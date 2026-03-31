import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_manage/services/api_client.dart';

class AuthService {
  final ApiClient _apiClient;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService(this._apiClient);

  Future<void> login(String username) async {
    try {
      // The backend expects form data for OAuth2
      final formData = FormData.fromMap({'username': username, 'password': ''});

      final response = await _apiClient.dio.post('/login', data: formData);

      // Save the token!
      final token = response.data['access_token'];
      await _storage.write(key: 'jwt_token', value: token);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}
