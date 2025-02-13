class CartItem {
  final String image;
  final String name;
  final double price;
  final double oldPrice;
  int quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.quantity,
  });
}