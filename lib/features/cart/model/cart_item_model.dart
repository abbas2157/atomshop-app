class CartItemModel {
  int? id;
  Product? product;
  String? productAdvancePrice;
  String? productPrice;
  int? quantity;

  CartItemModel(
      {this.id,
      this.product,
      this.productAdvancePrice,
      this.productPrice,
      this.quantity});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productAdvancePrice = json['product_advance_price'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
  }
}

class Product {
  int? id;
  String? title;
  String? price;
  String? picture;
  String? total;

  Product({this.id, this.title, this.price, this.picture, this.total});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    picture = json['picture'];
    total = json['total'];
  }
}
