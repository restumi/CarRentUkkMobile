import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _termsAcceptedKey = 'terms_accepted';
  static const String _verificationsStatusKey = 'verification_status';
  static const String _verificationsEmailKey = 'verification_email';

  // ====================== LOGIN ======================
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await ApiService.login(email, password);

      final isSuccess =
          response['success'] == true || response['success'] == 'true';
      final hasToken = response['token'] != null && response['token'] is String;

      if (isSuccess && hasToken) {
        final token = response['token'] as String;
        final userData = response['data'] ?? {};

        // Save user token
        await _saveToken(token);
        await _saveUserData(userData);

        return response;
      } else {
        throw Exception(
          'Login gagal: ${response['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  // ====================== LOGOUT ======================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  // ====================== CHECK LOGIN STATUS ======================
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ====================== GET TOKEN ======================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // ====================== SAVE TOKEN ======================
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // ====================== GET USER DATA ======================
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userKey);
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // ====================== SAVE USER DATA ======================
  static Future<void> _saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userData));
  }

  // ====================== TERMS ACCEPTANCE ======================
  static Future<bool> isTermsAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_termsAcceptedKey) ?? false;
  }

  static Future<void> setTermsAccepted(bool accepted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_termsAcceptedKey, accepted);
  }

  // ====================== VERIFY TOKEN ======================
  static Future<bool> verifyToken() async {
    try {
      final token = await getToken();
      if (token == null) return false;

      await ApiService.getCars(token);
      return true;
    } catch (e) {
      await logout();
      return false;
    }
  }

  // ====================== REGIST RESULT ======================
  static Future<void> saveVerifyData({
    required String email,
    required String status,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_verificationsStatusKey, status);
    await prefs.setString(_verificationsEmailKey, email);
  }

  // ====================== GET STATUS ======================
  static Future<String?> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_verificationsStatusKey);
  }

  // ====================== GET EMAIL ======================
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_verificationsEmailKey);
  }

  // ====================== CHECK STATUS ======================
  static Future<bool> isUserVerifications() async {
    final status = await getStatus();
    return status != null && status != 'rejected';
  }

  // ====================== REMOVE VERIFICATION DATA ======================
  static Future<void> removeVerificationData() async {
    final perfs = await SharedPreferences.getInstance();

    await perfs.remove(_verificationsStatusKey);
    await perfs.remove(_verificationsEmailKey);
  }
}
