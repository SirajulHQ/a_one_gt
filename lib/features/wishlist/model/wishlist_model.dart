import 'package:a_one_gt/features/product/model/product_model.dart';

class WishlistModel {
  final String id;
  final String userId;
  final List<WishlistItemModel> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => WishlistItemModel.fromJson(item))
              .toList() ??
          [],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  int get itemCount => items.length;

  bool containsProduct(String productId) {
    return items.any((item) => item.productId == productId);
  }
}

class WishlistItemModel {
  final String id;
  final String productId;
  final ProductModel product;
  final DateTime addedAt;

  WishlistItemModel({
    required this.id,
    required this.productId,
    required this.product,
    required this.addedAt,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      product: ProductModel.fromJson(json['product'] ?? {}),
      addedAt: DateTime.parse(
        json['added_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product': product.toJson(),
      'added_at': addedAt.toIso8601String(),
    };
  }
}

class AddToWishlistModel {
  final String productId;

  AddToWishlistModel({required this.productId});

  Map<String, dynamic> toJson() {
    return {'product_id': productId};
  }
}
