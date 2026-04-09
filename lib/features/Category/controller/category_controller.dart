import 'package:a_one_gt/features/category/model/category_model.dart';
import 'package:a_one_gt/features/category/viewmodel/category_viewmodel.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final CategoryViewModel _viewModel = CategoryViewModel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CategoryModel? _categoryData;
  CategoryModel? get categoryData => _categoryData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Category> get categories => _categoryData?.categories ?? [];
  List<CategoryBanner> get banners => _categoryData?.banners ?? [];

  Future<void> loadCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categoryData = await _viewModel.fetchCategories();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategoriesWithBanners() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categoryData = await _viewModel.fetchCategoriesWithBanners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _categoryData = null;
    _errorMessage = null;
    notifyListeners();
  }
}
