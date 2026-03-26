class Product {
  final String id;
  final String name;
  final String image;
  final List<String> images;
  final double price;
  final String category;
  final String subCategory;
  final double rating;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    List<String>? images,
    required this.price,
    required this.category,
    required this.subCategory,
    required this.rating,
    required this.description,
  }) : images = images != null && images.isNotEmpty ? images : [image];
}
