import 'package:a_one_gt/features/home/model/home_model.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  List<BannerModel> _banners = [];
  List<CategoryModel> _categories = [];
  List<SubCategoryModel> _subCategories = [];
  List<DealModel> _deals = [];
  List<SubCategoryModel> _filteredSubCategories = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  List<BannerModel> get banners => _banners;
  List<CategoryModel> get categories => _categories;
  List<SubCategoryModel> get subCategories => _subCategories;
  List<DealModel> get deals => _deals;
  List<SubCategoryModel> get filteredSubCategories => _filteredSubCategories;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Setters
  void setBanners(List<BannerModel> banners) {
    _banners = banners;
    notifyListeners();
  }

  void setCategories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  void setSubCategories(List<SubCategoryModel> subCategories) {
    _subCategories = subCategories;
    _filterSubCategories();
    notifyListeners();
  }

  void setDeals(List<DealModel> deals) {
    _deals = deals;
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

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  // Category selection
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    _filterSubCategories();
    notifyListeners();
  }

  // Search functionality
  void setSearchQuery(String query) {
    _searchQuery = query;
    _filterSubCategories();
    notifyListeners();
  }

  // Filter subcategories based on selected category and search query
  void _filterSubCategories() {
    List<SubCategoryModel> filtered = _subCategories;

    // Filter by category
    if (_selectedCategory != 'All') {
      final selectedCategoryModel = _categories.firstWhere(
        (cat) => cat.name == _selectedCategory,
        orElse: () => CategoryModel(
          id: '',
          name: '',
          description: '',
          imageUrl: '',
          subCategories: [],
          isActive: true,
          order: 0,
        ),
      );

      if (selectedCategoryModel.id.isNotEmpty) {
        filtered = filtered
            .where((sub) => sub.categoryId == selectedCategoryModel.id)
            .toList();
      }
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (sub) =>
                sub.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                sub.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    _filteredSubCategories = filtered;
  }

  // Get subcategories for a specific category
  List<SubCategoryModel> getSubCategoriesForCategory(String categoryId) {
    return _subCategories.where((sub) => sub.categoryId == categoryId).toList();
  }

  // Get active deals
  List<DealModel> getActiveDeals() {
    final now = DateTime.now();
    return _deals
        .where(
          (deal) =>
              deal.isActive &&
              deal.startDate.isBefore(now) &&
              deal.endDate.isAfter(now),
        )
        .toList();
  }

  // Get category by name
  CategoryModel? getCategoryByName(String name) {
    try {
      return _categories.firstWhere((cat) => cat.name == name);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
