class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? actionUrl;
  final String? actionType; // 'category', 'product', 'external'
  final bool isActive;
  final int order;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.actionUrl,
    this.actionType,
    required this.isActive,
    required this.order,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      imageUrl: json['image_url'] ?? '',
      actionUrl: json['action_url'],
      actionType: json['action_type'],
      isActive: json['is_active'] ?? true,
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'image_url': imageUrl,
      'action_url': actionUrl,
      'action_type': actionType,
      'is_active': isActive,
      'order': order,
    };
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String? iconUrl;
  final List<SubCategoryModel> subCategories;
  final bool isActive;
  final int order;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.iconUrl,
    required this.subCategories,
    required this.isActive,
    required this.order,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      iconUrl: json['icon_url'],
      subCategories:
          (json['sub_categories'] as List<dynamic>?)
              ?.map((item) => SubCategoryModel.fromJson(item))
              .toList() ??
          [],
      isActive: json['is_active'] ?? true,
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'icon_url': iconUrl,
      'sub_categories': subCategories.map((sub) => sub.toJson()).toList(),
      'is_active': isActive,
      'order': order,
    };
  }
}

class SubCategoryModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String categoryId;
  final bool isActive;
  final int order;
  final double? rating;
  final String? deliveryTime;
  final String? priceRange;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.isActive,
    required this.order,
    this.rating,
    this.deliveryTime,
    this.priceRange,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      categoryId: json['category_id'] ?? '',
      isActive: json['is_active'] ?? true,
      order: json['order'] ?? 0,
      rating: json['rating']?.toDouble(),
      deliveryTime: json['delivery_time'],
      priceRange: json['price_range'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'category_id': categoryId,
      'is_active': isActive,
      'order': order,
      'rating': rating,
      'delivery_time': deliveryTime,
      'price_range': priceRange,
    };
  }
}

class DealModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double originalPrice;
  final double discountedPrice;
  final double discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String? productId;
  final String? categoryId;

  DealModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.productId,
    this.categoryId,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      discountedPrice: (json['discounted_price'] ?? 0).toDouble(),
      discountPercentage: (json['discount_percentage'] ?? 0).toDouble(),
      startDate: DateTime.parse(
        json['start_date'] ?? DateTime.now().toIso8601String(),
      ),
      endDate: DateTime.parse(
        json['end_date'] ?? DateTime.now().toIso8601String(),
      ),
      isActive: json['is_active'] ?? true,
      productId: json['product_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'original_price': originalPrice,
      'discounted_price': discountedPrice,
      'discount_percentage': discountPercentage,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive,
      'product_id': productId,
      'category_id': categoryId,
    };
  }
}
