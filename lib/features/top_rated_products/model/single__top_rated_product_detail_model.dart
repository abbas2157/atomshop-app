class TopRatedProductDetailModel {
  final int id;
  final String title;
  final String detailPageTitle;
  final String price;
  final int variationPrice;
  final int minAdvancePrice;
  final String picture;
  final List<String> gallery;
  final String shortDescription;
  final String longDescription;
  final List<ProductVariant> colors;
  final List<ProductVariant> memories;

  TopRatedProductDetailModel({
    required this.id,
    required this.title,
    required this.detailPageTitle,
    required this.price,
    required this.variationPrice,
    required this.minAdvancePrice,
    required this.picture,
    required this.gallery,
    required this.shortDescription,
    required this.longDescription,
    required this.colors,
    required this.memories,
  });

  factory TopRatedProductDetailModel.fromJson(Map<String, dynamic> json) {
    return TopRatedProductDetailModel(
      id: json['id'],
      title: json['title'],
      detailPageTitle: json['detail_page_title'],
      price: json['price'],
      variationPrice: json['variation_price'],
      minAdvancePrice: json['min_advance_price'],
      picture: json['picture'],
      gallery: (json['gallery'] as List)
          .map((img) => img['url'] as String) // ✅ Explicitly cast to String
          .toList(),
      shortDescription: json['short_description'] ?? '',
      longDescription: json['long_description'] ?? '',
      colors: (json['colors'] as List)
          .map((color) => ProductVariant.fromJson(color))
          .toList(),
      memories: (json['memories'] as List)
          .map((memory) => ProductVariant.fromJson(memory))
          .toList(),
    );
  }
}

class ProductVariant {
  final int id;
  final String title;
  final int? variationPrice;
  final bool active;

  ProductVariant({
    required this.id,
    required this.title,
    this.variationPrice,
    required this.active,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      title: json['title'],
      variationPrice: json['variation_price'],
      active: json['active'] ?? false,
    );
  }
}
