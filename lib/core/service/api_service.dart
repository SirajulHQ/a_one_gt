import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  // final String baseUrl = 'http://127.0.0.1:8000';
  final String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  final bool useMockData = true;

  // Headers for API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    log('🌐 GET request to: $endpoint');

    if (useMockData) {
      return _mockResponse(endpoint, 'GET');
    }

    try {
      final Uri url = Uri.parse('$baseUrl$endpoint');
      log('🎯 Final URL: $url');

      final response = await http.get(url, headers: _headers);

      log('📊 Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      log('💥 GET request failed: $e');
      return _errorResponse('Network error: ${e.toString()}');
    }
  }

  // POST request
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    log('🌐 POST request to: $endpoint');
    log('📤 Request data: $data');

    if (useMockData) {
      return _mockResponse(endpoint, 'POST', data);
    }

    try {
      final Uri url = Uri.parse('$baseUrl$endpoint');
      log('🎯 Final URL: $url');

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(data),
      );

      log('📊 Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      log('💥 POST request failed: $e');
      return _errorResponse('Network error: ${e.toString()}');
    }
  }

  // PUT request
  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    log('🌐 PUT request to: $endpoint');
    log('📤 Request data: $data');

    if (useMockData) {
      return _mockResponse(endpoint, 'PUT', data);
    }

    try {
      final Uri url = Uri.parse('$baseUrl$endpoint');
      log('🎯 Final URL: $url');

      final response = await http.put(
        url,
        headers: _headers,
        body: jsonEncode(data),
      );

      log('📊 Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      log('💥 PUT request failed: $e');
      return _errorResponse('Network error: ${e.toString()}');
    }
  }

  // DELETE request
  Future<Map<String, dynamic>> delete(
    String endpoint, [
    Map<String, dynamic>? data,
  ]) async {
    log('🌐 DELETE request to: $endpoint');
    if (data != null) log('📤 Request data: $data');

    if (useMockData) {
      return _mockResponse(endpoint, 'DELETE', data);
    }

    try {
      final Uri url = Uri.parse('$baseUrl$endpoint');
      log('🎯 Final URL: $url');

      final response = await http.delete(
        url,
        headers: _headers,
        body: data != null ? jsonEncode(data) : null,
      );

      log('📊 Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      log('💥 DELETE request failed: $e');
      return _errorResponse('Network error: ${e.toString()}');
    }
  }

  // File upload
  Future<Map<String, dynamic>> uploadFile(
    String endpoint,
    String filePath,
  ) async {
    log('🌐 File upload to: $endpoint');
    log('📁 File path: $filePath');

    if (useMockData) {
      return _mockFileUploadResponse(endpoint, filePath);
    }

    try {
      final Uri url = Uri.parse('$baseUrl$endpoint');
      log('🎯 Final URL: $url');

      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      log('📊 Status Code: ${response.statusCode}');
      log('📦 Response Body: $responseBody');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(responseBody);
      } else {
        return _errorResponse(
          'Upload failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('💥 File upload failed: $e');
      return _errorResponse('Upload error: ${e.toString()}');
    }
  }

  // Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        return _successResponse({'message': 'Success'});
      }
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        return _errorResponse(errorBody['message'] ?? 'Request failed');
      } catch (e) {
        return _errorResponse(
          'Request failed with status: ${response.statusCode}',
        );
      }
    }
  }

  // Mock response for development
  Map<String, dynamic> _mockResponse(
    String endpoint,
    String method, [
    Map<String, dynamic>? data,
  ]) {
    log('🎭 Mock $method response for: $endpoint');

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 500));

    // Mock different responses based on endpoint
    if (endpoint.contains('/auth/')) {
      return _mockAuthResponse(endpoint, method, data);
    } else if (endpoint.contains('/user/')) {
      return _mockUserResponse(endpoint, method, data);
    } else if (endpoint.contains('/products')) {
      return _mockProductsResponse(endpoint, method, data);
    } else if (endpoint.contains('/orders')) {
      return _mockOrdersResponse(endpoint, method, data);
    } else if (endpoint.contains('/addresses')) {
      return _mockAddressesResponse(endpoint, method, data);
    } else if (endpoint.contains('/wishlist')) {
      return _mockWishlistResponse(endpoint, method, data);
    } else if (endpoint.contains('/categories')) {
      return _mockCategoriesResponse(endpoint, method, data);
    } else {
      return _successResponse({'message': 'Mock response for $endpoint'});
    }
  }

  // Mock auth responses
  Map<String, dynamic> _mockAuthResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    if (endpoint.contains('/login')) {
      return _successResponse({
        'user': {'id': 1, 'name': 'John Doe', 'email': 'john@example.com'},
        'token': 'mock_token_123',
      });
    } else if (endpoint.contains('/register')) {
      return _successResponse({
        'user': {'id': 1, 'name': 'John Doe', 'email': 'john@example.com'},
        'message': 'User registered successfully',
      });
    }
    return _successResponse({'message': 'Auth operation successful'});
  }

  // Mock user responses
  Map<String, dynamic> _mockUserResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    if (endpoint.contains('/profile')) {
      return _successResponse({
        'id': '1',
        'name': 'John Doe',
        'email': 'john@example.com',
        'phone': '+971501234567',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'is_email_verified': true,
        'is_phone_verified': true,
      });
    } else if (endpoint.contains('/settings')) {
      return _successResponse({
        'push_notifications': true,
        'language': 'en',
        'theme': 'light',
        'location_services': true,
        'email_notifications': true,
        'sms_notifications': false,
      });
    }
    return _successResponse({'message': 'User operation successful'});
  }

  // Mock products responses
  Map<String, dynamic> _mockProductsResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    return _successResponse([
      {
        'id': '1',
        'name': 'Fresh Apples',
        'description': 'Organic red apples',
        'price': 25.99,
        'images': ['assets/images/grocery.png'],
        'category_id': '1',
        'sub_category_id': '1',
        'rating': 4.5,
        'review_count': 120,
        'is_available': true,
        'stock_quantity': 50,
        'unit': 'kg',
        'tags': ['fresh', 'organic'],
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    ]);
  }

  // Mock orders responses
  Map<String, dynamic> _mockOrdersResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    return _successResponse([
      {
        'id': '1',
        'order_id': '#A1B2C3',
        'user_id': '1',
        'status': 'delivered',
        'total_amount': 499.0,
        'items': [
          {
            'id': '1',
            'product_id': '1',
            'product_name': 'Chicken Burger',
            'quantity': 1,
            'price': 299.0,
            'total': 299.0,
          },
        ],
        'delivery_address': {
          'street': 'Dubai Marina',
          'city': 'Dubai',
          'state': 'Dubai',
          'country': 'UAE',
        },
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    ]);
  }

  // Mock addresses responses
  Map<String, dynamic> _mockAddressesResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    return _successResponse([
      {
        'id': '1',
        'user_id': '1',
        'name': 'John Doe',
        'phone': '+971501234567',
        'street': 'Dubai Marina Walk',
        'city': 'Dubai',
        'state': 'Dubai',
        'pincode': '12345',
        'country': 'UAE',
        'type': 'home',
        'is_default': true,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    ]);
  }

  // Mock wishlist responses
  Map<String, dynamic> _mockWishlistResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    return _successResponse({
      'id': '1',
      'user_id': '1',
      'items': [
        {
          'id': '1',
          'product_id': '1',
          'product': {
            'id': '1',
            'name': 'Fresh Apples',
            'price': 25.99,
            'images': ['assets/images/grocery.png'],
          },
          'added_at': DateTime.now().toIso8601String(),
        },
      ],
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  // Mock categories responses
  Map<String, dynamic> _mockCategoriesResponse(
    String endpoint,
    String method,
    Map<String, dynamic>? data,
  ) {
    return _successResponse([
      {
        'id': '1',
        'name': 'Grocery',
        'description': 'Fresh groceries and food items',
        'image_url': 'assets/images/grocery.png',
        'sub_categories': [
          {
            'id': '1',
            'name': 'Fruits',
            'description': 'Fresh fruits',
            'image_url': 'assets/images/grocery.png',
            'category_id': '1',
            'is_active': true,
            'order': 1,
          },
        ],
        'is_active': true,
        'order': 1,
      },
    ]);
  }

  // Mock file upload response
  Map<String, dynamic> _mockFileUploadResponse(
    String endpoint,
    String filePath,
  ) {
    return _successResponse({
      'avatar_url':
          'https://example.com/uploads/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
      'message': 'File uploaded successfully',
    });
  }

  // Helper methods for consistent response format
  Map<String, dynamic> _successResponse(dynamic data) {
    return {'success': true, 'data': data, 'message': 'Operation successful'};
  }

  Map<String, dynamic> _errorResponse(String message) {
    return {'success': false, 'data': null, 'message': message};
  }
}
