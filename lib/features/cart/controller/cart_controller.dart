import 'package:flutter/foundation.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/cart/models/cart_item.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // Per-category cart storage
  final Map<String, List<CartItem>> _categoryItems = {};

  List<CartItem> itemsForCategory(String category) =>
      List.unmodifiable(_categoryItems[category] ?? []);

  int itemCountForCategory(String category) => (_categoryItems[category] ?? [])
      .fold(0, (sum, item) => sum + item.quantity);

  double totalPriceForCategory(String category) =>
      (_categoryItems[category] ?? []).fold(
        0.0,
        (sum, item) => sum + item.totalPrice,
      );

  bool isEmptyForCategory(String category) =>
      (_categoryItems[category] ?? []).isEmpty;

  // Total across all categories (for global badge if needed)
  int get totalItemCount => _categoryItems.values.fold(
    0,
    (sum, list) => sum + list.fold(0, (s, i) => s + i.quantity),
  );

  void addItem(Product product, {int quantity = 1}) {
    final category = product.category;
    _categoryItems.putIfAbsent(category, () => []);
    final list = _categoryItems[category]!;
    final existingIndex = list.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      list[existingIndex].quantity += quantity;
    } else {
      list.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeItem(String productId, String category) {
    _categoryItems[category]?.removeWhere(
      (item) => item.product.id == productId,
    );
    notifyListeners();
  }

  void incrementQuantity(String productId, String category) {
    final list = _categoryItems[category];
    if (list == null) return;
    final index = list.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      list[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId, String category) {
    final list = _categoryItems[category];
    if (list == null) return;
    final index = list.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (list[index].quantity > 1) {
        list[index].quantity--;
      } else {
        list.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart(String category) {
    _categoryItems[category]?.clear();
    notifyListeners();
  }

  CartItem? getItem(String productId, String category) {
    try {
      return (_categoryItems[category] ?? []).firstWhere(
        (item) => item.product.id == productId,
      );
    } catch (e) {
      return null;
    }
  }

  bool containsProduct(String productId, String category) {
    return (_categoryItems[category] ?? []).any(
      (item) => item.product.id == productId,
    );
  }
}
