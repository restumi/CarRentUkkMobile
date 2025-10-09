import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.15.104.156:8000/api";

  // ====================== AUTH ======================
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to Login: ${response.body}');
    }
  }

  // ====================== CARS ======================
  static Future<List<dynamic>> getCars(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cars'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("failed to get cars: ${response.body}");
    }
  }

  static Future<Map<String, dynamic>> getCarDetail(int id, String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/cars/$id"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get detail car: ${response.body}');
    }
  }

  // ====================== DRIVERS ======================
  static Future<List<dynamic>> getDriver(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/drivers"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to get drivers: ${response.body}');
    }
  }

  // ====================== TRANSACTION ======================
  static Future<List<dynamic>> getTransaction(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/transactions'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to get transaction: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> createTransaction(
    Map<String, dynamic> data,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to create transaction: ${response.body}');
    }
  }
}
