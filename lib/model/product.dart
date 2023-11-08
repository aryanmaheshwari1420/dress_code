class Product {
  final bool status;
  final String message;
  final List<ProductObject> object;
  final int totalItems;

  Product({
    required this.status,
    required this.message,
    required this.object,
    required this.totalItems,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<dynamic> objectList = json['object'];
    final List<ProductObject> productList = objectList
        .map((item) => ProductObject.fromJson(item as Map<String, dynamic>))
        .toList();

    return Product(
      status: json['status'] as bool,
      message: json['message'] as String,
      object: productList,
      totalItems: json['totalItems'] as int,
    );
  }
}

class ProductObject {
  final int id;
  final String description;
  final String keywords;
  final String mediaUrl;
  final List<Category> category;
  final String name;
  final double rating;
  final List<Variant> variants;
  final String promotionalTag;
  final List<dynamic> addedVariant;
  final int inWishlist;

  ProductObject({
    required this.id,
    required this.description,
    required this.keywords,
    required this.mediaUrl,
    required this.category,
    required this.name,
    required this.rating,
    required this.variants,
    required this.promotionalTag,
    required this.addedVariant,
    required this.inWishlist,
  });

  factory ProductObject.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoryList = json['category'];
    final List<Category> categoryData = categoryList
        .map((item) => Category.fromJson(item as Map<String, dynamic>))
        .toList();

    final List<dynamic> variantList = json['variants'];
    final List<Variant> variantData = variantList
        .map((item) => Variant.fromJson(item as Map<String, dynamic>))
        .toList();

    return ProductObject(
      id: json['id'] as int,
      description: json['description'] ?? "", // Replace null with an empty string
      keywords: json['keywords'] ?? "", // Replace null with an empty string
      mediaUrl: json['mediaUrl'] ?? "", // Replace null with an empty string
      category: categoryData,
      name: json['name'] ?? "", // Replace null with an empty string
      rating: (json['rating'] ?? 0.0).toDouble(),
      variants: variantData,
      promotionalTag: json['promotionalTag'] ?? "", // Replace null with an empty string
      addedVariant: json['addedVariant'] ?? [], // Replace null with an empty list
      inWishlist: json['inWishlist'] as int,
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] ?? "", // Replace null with an empty string
    );
  }
}

class Variant {
  final String variant;
  final String sku;
  final int isOutOfStock;
  final double sellingPrice;
  final double mrp;

  Variant({
    required this.variant,
    required this.sku,
    required this.isOutOfStock,
    required this.sellingPrice,
    required this.mrp,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      variant: json['variant'] ?? "", // Replace null with an empty string
      sku: json['sku'] ?? "", // Replace null with an empty string
      isOutOfStock: json['isOutOfStock'] as int,
      sellingPrice: (json['sellingPrice'] ?? 0.0).toDouble(),
      mrp: (json['mrp'] ?? 0.0).toDouble(),
    );
  }
}
