import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);

  void toggle(Product product) {
    if (isWishlisted(product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isWishlisted(String productId) => state.any((p) => p.id == productId);
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (ref) => WishlistNotifier(),
);
