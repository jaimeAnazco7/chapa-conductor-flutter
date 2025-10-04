import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/auth.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = await _storageService.getUserData();
    notifyListeners();
  }

  Future<AuthResponse> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _authService.login(email, password);
      
      if (response.success && response.user != null) {
        _user = response.user;
        await _storageService.saveUserData(_user!);
        if (response.token != null) {
          await _storageService.saveToken(response.token!);
        }
        await _storageService.setLoggedIn(true);
      }
      
      return response;
    } catch (e) {
      _error = e.toString();
      return AuthResponse(
        success: false,
        message: 'Error: ${e.toString()}',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<AuthResponse> register(
    String nombre,
    String apellido,
    String email,
    String telefono,
    String password,
    String unidad,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = RegisterRequest(
        nombre: nombre,
        apellido: apellido,
        email: email,
        telefono: telefono,
        password: password,
        unidad: unidad,
      );
      
      final response = await _authService.register(request);
      return response;
    } catch (e) {
      _error = e.toString();
      return AuthResponse(
        success: false,
        message: 'Error: ${e.toString()}',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    _error = null;
    await _storageService.clearAllData();
    notifyListeners();
  }

  Future<void> refreshUser() async {
    if (_user != null) {
      final response = await _authService.checkDriverStatus(_user!.id);
      if (response.success && response.user != null) {
        _user = response.user;
        await _storageService.saveUserData(_user!);
        notifyListeners();
      }
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
