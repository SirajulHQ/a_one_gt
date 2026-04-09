import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/wishlist/model/wishlist_model.dart';
import 'package:a_one_gt/features/wishlist/viewmodel/wishlist_viewmodel.dart';
import 'package:flutter/foundation.dart';

class WishlistController {
  final ApiService _apiService = ApiService();
  final WishlistViewModel _viewModel = WishlistViewModel();

  WishlistViewModel get viewModel => _viewModel;

  /// Get user wishlist
  Future<void> getWishlist() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/wishlist');

      if (response['success'] == true) {
        final wishlistData = response['data'] ?? {};
        final wishlist = WishlistModel.fromJson(wishlistData);
        _viewModel.setWishlist(wishlist);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch wishlist');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('WishlistController.getWishlist error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Add product to wishlist
  Future<void> addToWishlist(String productId) async {
    try {
      _viewModel.setLoading(true);

      final addToWishlistData = AddToWishlistModel(productId: productId);
      final response = await _apiService.post(
        '/wishlist/add',
        addToWishlistData.toJson(),
      );

      if (response['success'] == true) {
        final itemData = response['data'] ?? {};
        final item = WishlistItemModel.fromJson(itemData);
        _viewModel.addItem(item);
        _viewModel.setMessage('Product added to wishlist');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to add to wishlist');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('WishlistController.addToWishlist error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Remove product from wishlist
  Future<void> removeFromWishlist(String productId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.delete('/wishlist/remove/$productId');

      if (response['success'] == true) {
        _viewModel.removeItem(productId);
        _viewModel.setMessage('Product removed from wishlist');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to remove from wishlist',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('WishlistController.removeFromWishlist error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Toggle product in wishlist
  Future<void> toggleWishlist(String productId) async {
    if (_viewModel.isProductInWishlist(productId)) {
      await removeFromWishlist(productId);
    } else {
      await addToWishlist(productId);
    }
  }

  /// Clear entire wishlist
  Future<void> clearWishlist() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.delete('/wishlist/clear');

      if (response['success'] == true) {
        _viewModel.clearWishlist();
        _viewModel.setMessage('Wishlist cleared');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to clear wishlist');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('WishlistController.clearWishlist error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Move wishlist items to cart
  Future<void> moveToCart(List<String> productIds) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/wishlist/move-to-cart', {
        'product_ids': productIds,
      });

      if (response['success'] == true) {
        // Remove moved items from wishlist
        for (String productId in productIds) {
          _viewModel.removeItem(productId);
        }
        _viewModel.setMessage('Items moved to cart');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to move items to cart',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('WishlistController.moveToCart error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Check if product is in wishlist
  bool isProductInWishlist(String productId) {
    return _viewModel.isProductInWishlist(productId);
  }

  /// Get wishlist item count
  int getItemCount() {
    return _viewModel.itemCount;
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
