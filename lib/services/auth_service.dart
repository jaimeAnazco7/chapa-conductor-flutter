import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/auth.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<AuthResponse> login(String email, String password) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
      
      final response = await http.post(
        url,
        headers: ApiConstants.defaultHeaders,
        body: jsonEncode(LoginRequest(email: email, password: password).toJson()),
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectTimeout),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        final data = jsonDecode(response.body);
        return AuthResponse(
          success: false,
          message: data['message'] ?? 'Error en el login',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Error de conexión: ${e.toString()}',
      );
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}');
      
      final response = await http.post(
        url,
        headers: ApiConstants.defaultHeaders,
        body: jsonEncode(request.toJson()),
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectTimeout),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        final data = jsonDecode(response.body);
        return AuthResponse(
          success: false,
          message: data['message'] ?? 'Error en el registro',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Error de conexión: ${e.toString()}',
      );
    }
  }

  Future<AuthResponse> checkDriverStatus(int driverId) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.checkStatusEndpoint}/$driverId');
      
      final response = await http.get(
        url,
        headers: ApiConstants.defaultHeaders,
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectTimeout),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        final data = jsonDecode(response.body);
        return AuthResponse(
          success: false,
          message: data['message'] ?? 'Error al verificar estado',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Error de conexión: ${e.toString()}',
      );
    }
  }
}
