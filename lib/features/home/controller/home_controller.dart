import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/home/model/home_model.dart';
import 'package:a_one_gt/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  final ApiService _apiService = ApiService();
  final HomeViewModel _viewModel = HomeViewModel();

  HomeViewModel get viewModel => _viewModel;

  /// Get home page data (banners, categories, deals)
  Future<void> getHomeData() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/home');

      if (response['success'] == true) {
        final data = response['data'] ?? {};

        // Parse banners
        if (data['banners'] != null) {
          final List<dynamic> bannersData = data['banners'];
          final banners = bannersData
              .map((json) => BannerModel.fromJson(json))
              .toList();
          _viewModel.setBanners(banners);
        }

        // Parse categories
        if (data['categories'] != null) {
          final List<dynamic> categoriesData = data['categories'];
          final categories = categoriesData
              .map((json) => CategoryModel.fromJson(json))
              .toList();
          _viewModel.setCategories(categories);
        }

        // Parse deals
        if (data['deals'] != null) {
          final List<dynamic> dealsData = data['deals'];
          final deals = dealsData
              .map((json) => DealModel.fromJson(json))
              .toList();
          _viewModel.setDeals(deals);
        }
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch home data');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.getHomeData error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get categories
  Future<void> getCategories() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/categories');

      if (response['success'] == true) {
        final List<dynamic> categoriesData = response['data'] ?? [];
        final categories = categoriesData
            .map((json) => CategoryModel.fromJson(json))
            .toList();
        _viewModel.setCategories(categories);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch categories',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.getCategories error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get subcategories for a category
  Future<void> getSubCategories(String categoryId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get(
        '/categories/$categoryId/subcategories',
      );

      if (response['success'] == true) {
        final List<dynamic> subCategoriesData = response['data'] ?? [];
        final subCategories = subCategoriesData
            .map((json) => SubCategoryModel.fromJson(json))
            .toList();
        _viewModel.setSubCategories(subCategories);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch subcategories',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.getSubCategories error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get all subcategories
  Future<void> getAllSubCategories() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/subcategories');

      if (response['success'] == true) {
        final List<dynamic> subCategoriesData = response['data'] ?? [];
        final subCategories = subCategoriesData
            .map((json) => SubCategoryModel.fromJson(json))
            .toList();
        _viewModel.setSubCategories(subCategories);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch subcategories',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.getAllSubCategories error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get banners
  Future<void> getBanners() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/banners');

      if (response['success'] == true) {
        final List<dynamic> bannersData = response['data'] ?? [];
        final banners = bannersData
            .map((json) => BannerModel.fromJson(json))
            .toList();
        _viewModel.setBanners(banners);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch banners');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.getBanners error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get deals
  Future<void> getDeals() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/deals');

      if (response['success'] == true) {
        final List<dynamic> dealsData = response['data'] ?? [];
        final deals = dealsData
            .map((json) => DealModel.fromJson(json))
            .toList();
        _viewModel.setDeals(deals);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch deals');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.getDeals error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Search subcategories
  Future<void> searchSubCategories(String query) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/subcategories/search?q=$query');

      if (response['success'] == true) {
        final List<dynamic> subCategoriesData = response['data'] ?? [];
        final subCategories = subCategoriesData
            .map((json) => SubCategoryModel.fromJson(json))
            .toList();
        _viewModel.setSubCategories(subCategories);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to search subcategories',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HomeController.searchSubCategories error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Set selected category
  void setSelectedCategory(String category) {
    _viewModel.setSelectedCategory(category);
  }

  /// Set search query
  void setSearchQuery(String query) {
    _viewModel.setSearchQuery(query);
  }

  /// Clear error
  void clearError() {
    _viewModel.clearError();
  }

  /// Clear message
  void clearMessage() {
    _viewModel.clearMessage();
  }

  /// Dispose resources
  void dispose() {
    _viewModel.dispose();
  }
}
