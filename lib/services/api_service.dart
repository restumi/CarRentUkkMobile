import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:car_rent_mobile_app/services/models/car_model.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  static const String baseUrl = AppConfig.apiUrl;

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

  static Future<Map<String, dynamic>> getStatus(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/status?email=$email'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to get status : ${response.body}');
    }
  }

  // ====================== REGIST ======================
  static Future<Map<String, dynamic>> regist({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phoneNumber,
    required String address,
    required String nik,
    required File ktpImage,
    required File faceImage,
  }) async {
    final uri = Uri.parse('$baseUrl/register');
    final request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = passwordConfirmation;
    request.fields['nik'] = nik;
    request.fields['phone_number'] = phoneNumber;
    request.fields['address'] = address;
    request.files.add(
      await http.MultipartFile.fromPath('ktp_image', ktpImage.path),
    );
    request.files.add(
      await http.MultipartFile.fromPath('face_image', faceImage.path),
    );

    final response = await request.send();
    final responseStr = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return jsonDecode(responseStr);
    } else {
      try {
        final errorJson = jsonDecode(responseStr);
        throw Exception(
          'register gagal: ${errorJson['message'] ?? responseStr}',
        );
      } catch (e) {
        throw Exception(
          'register gagal: (${response.statusCode}): $responseStr',
        );
      }
    }
  }

  // ====================== CARS ======================
  static Future<List<Car>> getCars(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cars'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body['success'] == true) {
        final List<dynamic> jsonData = body['data'];
        return jsonData.map((e) => Car.fromJson(e)).toList();
      } else {
        throw Exception(body['error'] ?? 'failed to get cars');
      }
    } else {
      throw Exception("Error ${response.statusCode} : ${response.body}");
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
      final jsonResponse = jsonDecode(response.body);
      return List<dynamic>.from(jsonResponse['data']);
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
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['data'];
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
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to create transaction: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> createPayment(
    int transactionId,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/$transactionId/payment'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        return json['data'];
      } else {
        throw Exception(json['message'] ?? 'gagal memuat pembayaran');
      }
    } else {
      throw Exception('Error ${response.statusCode} : ${response.body}');
    }
  }
}
