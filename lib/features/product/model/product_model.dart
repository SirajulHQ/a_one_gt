class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final List<String> images;
  final String categoryId;
  final String subCategoryId;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final int stockQuantity;
  final String unit; // 'kg', 'piece', 'liter', etc.
  final Map<String, dynamic>? nutritionInfo;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.images,
    required this.categoryId,
    required this.subCategoryId,
    required this.rating,
    required this.reviewCount,
    required this.isAvailable,
    required this.stockQuantity,
    required this.unit,
    this.nutritionInfo,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      images: List<String>.from(json['images'] ?? []),
      categoryId: json['category_id'] ?? '',
      subCategoryId: json['sub_category_id'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      stockQuantity: json['stock_quantity'] ?? 0,
      unit: json['unit'] ?? 'piece',
      nutritionInfo: json['nutrition_info'],
      tags: List<String>.from(json['tags'] ?? []),
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
      'name': name,
      'description': description,
      'price': price,
      'original_price': originalPrice,
      'images': images,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'rating': rating,
      'review_count': reviewCount,
      'is_available': isAvailable,
      'stock_quantity': stockQuantity,
      'unit': unit,
      'nutrition_info': nutritionInfo,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }
}

class ProductReviewModel {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final double rating;
  final String comment;
  final List<String> images;
  final DateTime createdAt;
  final bool isVerifiedPurchase;

  ProductReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.comment,
    required this.images,
    required this.createdAt,
    required this.isVerifiedPurchase,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
      userAvatar: json['user_avatar'],
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      isVerifiedPurchase: json['is_verified_purchase'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'user_name': userName,
      'user_avatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'images': images,
      'created_at': createdAt.toIso8601String(),
      'is_verified_purchase': isVerifiedPurchase,
    };
  }
}

class ProductFilterModel {
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final List<String> categories;
  final List<String> subCategories;
  final List<String> tags;
  final bool? inStock;
  final String sortBy; // 'price_asc', 'price_desc', 'rating', 'newest'

  ProductFilterModel({
    this.minPrice,
    this.maxPrice,
    this.minRating,
    required this.categories,
    required this.subCategories,
    required this.tags,
    this.inStock,
    required this.sortBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'min_price': minPrice,
      'max_price': maxPrice,
      'min_rating': minRating,
      'categories': categories,
      'sub_categories': subCategories,
      'tags': tags,
      'in_stock': inStock,
      'sort_by': sortBy,
    };
  }
}
