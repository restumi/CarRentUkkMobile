import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData;

  // ====================== INITIALIZE ======================
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isLoggedIn = await AuthService.isLoggedIn();
      if (_isLoggedIn) {
        _userData = await AuthService.getUserData();
        _isLoggedIn = await AuthService.verifyToken();
        if (!_isLoggedIn) {
          _userData = null;
        }
      }
    } catch (e) {
      _isLoggedIn = false;
      _userData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  String? _lastError;
  String? get lastError => _lastError;
  // ====================== LOGIN ======================
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await AuthService.login(email, password);
      _isLoggedIn = true;
      _userData = response['user'];
      _lastError = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoggedIn = false;
      _userData = null;
      _lastError = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ====================== LOGOUT ======================
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await AuthService.logout();
    _isLoggedIn = false;
    _userData = null;
    _isLoading = false;
    notifyListeners();
  }

  // ====================== CHECK TERMS ======================
  Future<bool> isTermsAccepted() async {
    return await AuthService.isTermsAccepted();
  }

  Future<void> setTermsAccepted(bool accepted) async {
    await AuthService.setTermsAccepted(accepted);
  }
}
