import 'dart:convert';
import 'dart:developer';
import 'package:a_one_gt/features/auth/model/create_account_model.dart';
import 'package:http/http.dart' as http;

class CreateAccountViewmodel {
  // final String baseUrl = 'http://127.0.0.1:8000';
  final String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  final bool useMockData = true;

  Future<CreateAccountModel> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    log('🌐 Starting API call to register user');
    log('🔧 Base URL: $baseUrl');
    log('🎭 Using mock data: $useMockData');

    if (useMockData) {
      return _mockRegisterUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
    }

    final Uri url = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}api/auth/register/'
          : '$baseUrl/api/auth/register/',
    );

    log('🎯 Final API URL: $url');
    log(
      '📤 Request payload: firstName=$firstName, lastName=$lastName, email=$email',
    );

    try {
      log('📡 Making HTTP POST request...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
        }),
      );

      log('� Response received');
      log('📊 Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');
      log('🔍 Response Headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('✅ HTTP request successful');
        final body = json.decode(response.body);
        log('🔄 JSON decoded successfully');
        log('📋 Parsed response: $body');

        if (body['status'] == 'success') {
          log('🎉 API returned success status');
          final model = CreateAccountModel.fromJson(body);
          log('✨ Model created successfully');
          return model;
        } else {
          final errorMsg = body['message'] ?? 'Registration failed';
          log('⚠️ API returned error status: $errorMsg');
          throw Exception(errorMsg);
        }
      } else {
        final errorMsg = 'Request failed with status: ${response.statusCode}';
        log('❌ HTTP request failed: $errorMsg');
        log('📄 Error response body: ${response.body}');
        throw Exception(errorMsg);
      }
    } catch (e, stackTrace) {
      log('💥 Exception occurred: $e');
      log('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<CreateAccountModel> _mockRegisterUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    log('🎭 Using mock registration');
    log(
      '📤 Mock request: firstName=$firstName, lastName=$lastName, email=$email',
    );

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate different scenarios based on email
    if (email.toLowerCase().contains('error')) {
      log('❌ Mock: Simulating error scenario');
      throw Exception('Mock Error: Email already exists');
    }

    if (email.toLowerCase().contains('fail')) {
      log('❌ Mock: Simulating failure scenario');
      throw Exception('Mock Error: Registration failed');
    }

    // Simulate successful registration
    log('✅ Mock: Simulating successful registration');

    final mockResponse = {
      "status": "success",
      "message": "User registered successfully",
      "data": {
        "id": 123,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "created_at": DateTime.now().toIso8601String(),
      },
    };

    log('📦 Mock response: $mockResponse');

    final model = CreateAccountModel.fromJson(mockResponse);
    log('✨ Mock model created successfully');

    return model;
  }
}
