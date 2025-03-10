class OrderModel {
  final int id;
  final ProductModel product;
  final String advancePrice;
  final String totalDealPrice;
  final int installmentTenure;
  final String portal;
  final String status;

  OrderModel({
    required this.id,
    required this.product,
    required this.advancePrice,
    required this.totalDealPrice,
    required this.installmentTenure,
    required this.portal,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      advancePrice: json['advance_price'] ?? '0',
      totalDealPrice: json['total_deal_price'] ?? '0',
      installmentTenure: json['instalment_tenure'] ?? 0,
      portal: json['portal'] ?? 'Unknown',
      status: json['status'] ?? 'Pending',
    );
  }
}


class ProductModel {
  final int id;
  final String title;
  final String price;
  final String picture;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.picture,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      price: json['price'] ?? '0',
      picture: json['picture'] ??
          'https://via.placeholder.com/80', // Default image if missing
    );
  }
}

