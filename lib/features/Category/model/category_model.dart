class CategoryModel {
  final String status;
  final List<Category> categories;
  final List<CategoryBanner> banners;

  CategoryModel({
    required this.status,
    required this.categories,
    required this.banners,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json["status"] ?? "",
      categories:
          (json["categories"] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e))
              .toList() ??
          [],
      banners:
          (json["banners"] as List<dynamic>?)
              ?.map((e) => CategoryBanner.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "categories": categories.map((e) => e.toJson()).toList(),
      "banners": banners.map((e) => e.toJson()).toList(),
    };
  }
}

class Category {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? imageUrl;
  final String? iconUrl;
  final bool isActive;
  final int sortOrder;
  final int productCount;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.imageUrl,
    this.iconUrl,
    required this.isActive,
    required this.sortOrder,
    required this.productCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      description: json["description"],
      imageUrl: json["image_url"],
      iconUrl: json["icon_url"],
      isActive: json["is_active"] ?? true,
      sortOrder: json["sort_order"] ?? 0,
      productCount: json["product_count"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "image_url": imageUrl,
      "icon_url": iconUrl,
      "is_active": isActive,
      "sort_order": sortOrder,
      "product_count": productCount,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

class CategoryBanner {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final String? linkUrl;
  final String? linkType; // category, product, external
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;

  CategoryBanner({
    required this.id,
    required this.title,
    this.description,
    required this.imageUrl,
    this.linkUrl,
    this.linkType,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryBanner.fromJson(Map<String, dynamic> json) {
    return CategoryBanner(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"],
      imageUrl: json["image_url"] ?? "",
      linkUrl: json["link_url"],
      linkType: json["link_type"],
      isActive: json["is_active"] ?? true,
      sortOrder: json["sort_order"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image_url": imageUrl,
      "link_url": linkUrl,
      "link_type": linkType,
      "is_active": isActive,
      "sort_order": sortOrder,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
