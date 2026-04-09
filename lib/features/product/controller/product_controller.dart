import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/product/model/product_model.dart';
import 'package:a_one_gt/features/product/viewmodel/product_viewmodel.dart';
import 'package:flutter/foundation.dart';

class ProductController {
  final ApiService _apiService = ApiService();
  final ProductViewModel _viewModel = ProductViewModel();

  ProductViewModel get viewModel => _viewModel;

  /// Get all products with pagination
  Future<void> getProducts({int page = 1, int limit = 20}) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get(
        '/products?page=$page&limit=$limit',
      );

      if (response['success'] == true) {
        final List<dynamic> productsData = response['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        final bool append = page > 1;
        _viewModel.setProducts(products, append: append);
        _viewModel.setCurrentPage(page);
        _viewModel.setHasMoreProducts(products.length == limit);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.getProducts error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get products by category
  Future<void> getProductsByCategory(
    String categoryId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get(
        '/categories/$categoryId/products?page=$page&limit=$limit',
      );

      if (response['success'] == true) {
        final List<dynamic> productsData = response['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        final bool append = page > 1;
        _viewModel.setProducts(products, append: append);
        _viewModel.setCurrentPage(page);
        _viewModel.setHasMoreProducts(products.length == limit);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.getProductsByCategory error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get products by subcategory
  Future<void> getProductsBySubCategory(
    String subCategoryId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get(
        '/subcategories/$subCategoryId/products?page=$page&limit=$limit',
      );

      if (response['success'] == true) {
        final List<dynamic> productsData = response['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        final bool append = page > 1;
        _viewModel.setProducts(products, append: append);
        _viewModel.setCurrentPage(page);
        _viewModel.setHasMoreProducts(products.length == limit);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.getProductsBySubCategory error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get product details
  Future<void> getProductDetails(String productId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/products/$productId');

      if (response['success'] == true) {
        final productData = response['data'];
        final product = ProductModel.fromJson(productData);
        _viewModel.setSelectedProduct(product);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch product details',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.getProductDetails error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Search products
  Future<void> searchProducts(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get(
        '/products/search?q=$query&page=$page&limit=$limit',
      );

      if (response['success'] == true) {
        final List<dynamic> productsData = response['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        final bool append = page > 1;
        _viewModel.setProducts(products, append: append);
        _viewModel.setSearchQuery(query);
        _viewModel.setCurrentPage(page);
        _viewModel.setHasMoreProducts(products.length == limit);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to search products');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.searchProducts error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Filter products
  Future<void> filterProducts(
    ProductFilterModel filter, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post(
        '/products/filter?page=$page&limit=$limit',
        filter.toJson(),
      );

      if (response['success'] == true) {
        final List<dynamic> productsData = response['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        final bool append = page > 1;
        _viewModel.setProducts(products, append: append);
        _viewModel.setCurrentFilter(filter);
        _viewModel.setCurrentPage(page);
        _viewModel.setHasMoreProducts(products.length == limit);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to filter products');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.filterProducts error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get product reviews
  Future<void> getProductReviews(String productId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/products/$productId/reviews');

      if (response['success'] == true) {
        final List<dynamic> reviewsData = response['data'] ?? [];
        final reviews = reviewsData
            .map((json) => ProductReviewModel.fromJson(json))
            .toList();
        _viewModel.setReviews(reviews);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch reviews');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.getProductReviews error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get featured products
  Future<void> getFeaturedProducts() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/products/featured');

      if (response['success'] == true) {
        final List<dynamic> productsData = response['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();
        _viewModel.setProducts(products);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch featured products',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProductController.getFeaturedProducts error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Load more products (pagination)
  Future<void> loadMoreProducts() async {
    if (!_viewModel.hasMoreProducts || _viewModel.isLoading) return;

    final nextPage = _viewModel.currentPage + 1;
    await getProducts(page: nextPage);
  }

  /// Set search query
  void setSearchQuery(String query) {
    _viewModel.setSearchQuery(query);
  }

  /// Set filter
  void setFilter(ProductFilterModel filter) {
    _viewModel.setCurrentFilter(filter);
  }

  /// Clear filters
  void clearFilters() {
    _viewModel.setCurrentFilter(null);
    _viewModel.setSearchQuery('');
  }

  /// Reset pagination
  void resetPagination() {
    _viewModel.resetPagination();
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
