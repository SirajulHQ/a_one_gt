import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:a_one_gt/core/config/app_config.dart';
import 'package:a_one_gt/core/service/token_storage_service.dart';
import 'package:a_one_gt/features/my_orders/model/my_orders_model.dart';

class MyOrdersViewModel {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<MyOrdersModel> fetchOrders({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (status != null && status.isNotEmpty) 'status': status,
    };

    final Uri url = Uri.parse(
      baseUrl.endsWith('/') ? '${baseUrl}orders' : '$baseUrl/orders',
    ).replace(queryParameters: queryParams);

    final String? token = await TokenStorageService.getAccessToken();

    try {
      log('➡️ Request URL: $url');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      log('📦 Response: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'success') {
          return MyOrdersModel.fromJson(body);
        } else {
          throw Exception(body['message'] ?? 'Failed to load orders');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('❌ Error fetching orders: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Order> fetchOrderDetails({required String orderId}) async {
    final Uri url = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}orders/$orderId'
          : '$baseUrl/orders/$orderId',
    );

    final String? token = await TokenStorageService.getAccessToken();

    try {
      log('➡️ Request URL: $url');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      log('📦 Response: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'success') {
          return Order.fromJson(body['order']);
        } else {
          throw Exception(body['message'] ?? 'Failed to load order details');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('❌ Error fetching order details: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<bool> cancelOrder({required String orderId}) async {
    final Uri url = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}orders/$orderId/cancel'
          : '$baseUrl/orders/$orderId/cancel',
    );

    final String? token = await TokenStorageService.getAccessToken();

    try {
      log('➡️ Request URL: $url');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      log('📦 Response: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'success') {
          return true;
        } else {
          throw Exception(body['message'] ?? 'Failed to cancel order');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('❌ Error cancelling order: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<bool> returnOrder({
    required String orderId,
    required String reason,
  }) async {
    final Uri url = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}orders/$orderId/return'
          : '$baseUrl/orders/$orderId/return',
    );

    final String? token = await TokenStorageService.getAccessToken();

    try {
      log('➡️ Request URL: $url');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'reason': reason}),
      );

      log('📦 Response: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'success') {
          return true;
        } else {
          throw Exception(body['message'] ?? 'Failed to return order');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('❌ Error returning order: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<bool> reorder({required String orderId}) async {
    final Uri url = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}orders/$orderId/reorder'
          : '$baseUrl/orders/$orderId/reorder',
    );

    final String? token = await TokenStorageService.getAccessToken();

    try {
      log('➡️ Request URL: $url');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      log('📦 Response: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'success') {
          return true;
        } else {
          throw Exception(body['message'] ?? 'Failed to reorder');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('❌ Error reordering: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
