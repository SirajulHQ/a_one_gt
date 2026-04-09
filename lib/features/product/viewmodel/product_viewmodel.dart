import 'package:a_one_gt/features/product/model/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];
  List<ProductReviewModel> _reviews = [];
  ProductModel? _selectedProduct;
  ProductFilterModel? _currentFilter;
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;
  String? _message;
  int _currentPage = 1;
  bool _hasMoreProducts = true;

  // Getters
  List<ProductModel> get products => _products;
  List<ProductModel> get filteredProducts => _filteredProducts;
  List<ProductReviewModel> get reviews => _reviews;
  ProductModel? get selectedProduct => _selectedProduct;
  ProductFilterModel? get currentFilter => _currentFilter;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;
  int get currentPage => _currentPage;
  bool get hasMoreProducts => _hasMoreProducts;

  // Setters
  void setProducts(List<ProductModel> products, {bool append = false}) {
    if (append) {
      _products.addAll(products);
    } else {
      _products = products;
    }
    _applyFilters();
    notifyListeners();
  }

  void setReviews(List<ProductReviewModel> reviews) {
    _reviews = reviews;
    notifyListeners();
  }

  void setSelectedProduct(ProductModel? product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void setCurrentFilter(ProductFilterModel? filter) {
    _currentFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void setHasMoreProducts(bool hasMore) {
    _hasMoreProducts = hasMore;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  // Apply filters and search
  void _applyFilters() {
    List<ProductModel> filtered = List.from(_products);

    // Apply search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (product) =>
                product.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                product.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                product.tags.any(
                  (tag) =>
                      tag.toLowerCase().contains(_searchQuery.toLowerCase()),
                ),
          )
          .toList();
    }

    // Apply filters
    if (_currentFilter != null) {
      final filter = _currentFilter!;

      // Price range
      if (filter.minPrice != null) {
        filtered = filtered
            .where((product) => product.price >= filter.minPrice!)
            .toList();
      }
      if (filter.maxPrice != null) {
        filtered = filtered
            .where((product) => product.price <= filter.maxPrice!)
            .toList();
      }

      // Rating
      if (filter.minRating != null) {
        filtered = filtered
            .where((product) => product.rating >= filter.minRating!)
            .toList();
      }

      // Categories
      if (filter.categories.isNotEmpty) {
        filtered = filtered
            .where((product) => filter.categories.contains(product.categoryId))
            .toList();
      }

      // Sub categories
      if (filter.subCategories.isNotEmpty) {
        filtered = filtered
            .where(
              (product) => filter.subCategories.contains(product.subCategoryId),
            )
            .toList();
      }

      // Tags
      if (filter.tags.isNotEmpty) {
        filtered = filtered
            .where(
              (product) => product.tags.any((tag) => filter.tags.contains(tag)),
            )
            .toList();
      }

      // Stock availability
      if (filter.inStock != null && filter.inStock!) {
        filtered = filtered
            .where(
              (product) => product.isAvailable && product.stockQuantity > 0,
            )
            .toList();
      }

      // Sorting
      switch (filter.sortBy) {
        case 'price_asc':
          filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_desc':
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'rating':
          filtered.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'newest':
          filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
      }
    }

    _filteredProducts = filtered;
  }

  // Get products by category
  List<ProductModel> getProductsByCategory(String categoryId) {
    return _products
        .where((product) => product.categoryId == categoryId)
        .toList();
  }

  // Get products by subcategory
  List<ProductModel> getProductsBySubCategory(String subCategoryId) {
    return _products
        .where((product) => product.subCategoryId == subCategoryId)
        .toList();
  }

  // Get featured products (high rating or new)
  List<ProductModel> getFeaturedProducts() {
    return _products
        .where(
          (product) =>
              product.rating >= 4.0 ||
              DateTime.now().difference(product.createdAt).inDays <= 7,
        )
        .toList();
  }

  // Get discounted products
  List<ProductModel> getDiscountedProducts() {
    return _products.where((product) => product.hasDiscount).toList();
  }

  // Reset pagination
  void resetPagination() {
    _currentPage = 1;
    _hasMoreProducts = true;
    notifyListeners();
  }

  // Increment page
  void incrementPage() {
    _currentPage++;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
