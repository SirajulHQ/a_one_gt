import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:a_one_gt/core/config/app_config.dart';
import 'package:a_one_gt/core/service/token_storage_service.dart';
import 'package:a_one_gt/features/category/model/category_model.dart';

class CategoryViewModel {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<CategoryModel> fetchCategories() async {
    final Uri url = Uri.parse(
      baseUrl.endsWith('/') ? '${baseUrl}categories' : '$baseUrl/categories',
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
          return CategoryModel.fromJson(body);
        } else {
          throw Exception(body['message'] ?? 'Failed to load categories');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('❌ Error fetching categories: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<CategoryModel> fetchCategoriesWithBanners() async {
    final Uri url = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}categories/with-banners'
          : '$baseUrl/categories/with-banners',
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
          return CategoryModel.fromJson(body);
        } else {
          throw Exception(body['message'] ?? 'Failed to load categories');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log(
        '❌ Error fetching categories with banners: $e',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
