import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000', // Use your local IP or emulator IP
      connectTimeout: const Duration(seconds: 5),
    ),
  );
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1. Read the token from secure storage
          final token = await _storage.read(key: 'jwt_token');

          // 2. If it exists, inject it into the Authorization header
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // 3. Continue with the request
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // If the backend returns a 401 Unauthorized, handle logout logic here
          if (e.response?.statusCode == 401) {
            print("Token expired or invalid. Need to log out user.");
            // You would trigger your state management to redirect to Login here
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Expose the configured Dio instance
  Dio get dio => _dio;
}
