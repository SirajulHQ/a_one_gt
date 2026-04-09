import 'package:a_one_gt/features/wishlist/model/wishlist_model.dart';
import 'package:flutter/foundation.dart';

class WishlistViewModel extends ChangeNotifier {
  WishlistModel? _wishlist;
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  WishlistModel? get wishlist => _wishlist;
  List<WishlistItemModel> get items => _wishlist?.items ?? [];
  int get itemCount => _wishlist?.itemCount ?? 0;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Setters
  void setWishlist(WishlistModel wishlist) {
    _wishlist = wishlist;
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

  // Add item to wishlist
  void addItem(WishlistItemModel item) {
    if (_wishlist != null) {
      final updatedItems = List<WishlistItemModel>.from(_wishlist!.items);

      // Check if item already exists
      if (!updatedItems.any(
        (existingItem) => existingItem.productId == item.productId,
      )) {
        updatedItems.add(item);

        _wishlist = WishlistModel(
          id: _wishlist!.id,
          userId: _wishlist!.userId,
          items: updatedItems,
          createdAt: _wishlist!.createdAt,
          updatedAt: DateTime.now(),
        );

        notifyListeners();
      }
    }
  }

  // Remove item from wishlist
  void removeItem(String productId) {
    if (_wishlist != null) {
      final updatedItems = _wishlist!.items
          .where((item) => item.productId != productId)
          .toList();

      _wishlist = WishlistModel(
        id: _wishlist!.id,
        userId: _wishlist!.userId,
        items: updatedItems,
        createdAt: _wishlist!.createdAt,
        updatedAt: DateTime.now(),
      );

      notifyListeners();
    }
  }

  // Check if product is in wishlist
  bool isProductInWishlist(String productId) {
    return _wishlist?.containsProduct(productId) ?? false;
  }

  // Clear wishlist
  void clearWishlist() {
    if (_wishlist != null) {
      _wishlist = WishlistModel(
        id: _wishlist!.id,
        userId: _wishlist!.userId,
        items: [],
        createdAt: _wishlist!.createdAt,
        updatedAt: DateTime.now(),
      );

      notifyListeners();
    }
  }

  // Get item by product ID
  WishlistItemModel? getItemByProductId(String productId) {
    try {
      return _wishlist?.items.firstWhere((item) => item.productId == productId);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
