class WishListItemModel {
  int? id;
  String? title;
  String? slug;
  String? picture;
  String? price;
  String? category;
  String? brand;

  WishListItemModel(
      {this.id,
      this.title,
      this.slug,
      this.picture,
      this.price,
      this.category,
      this.brand});

  WishListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    picture = json['picture'];
    price = json['price'];
    category = json['category'];
    brand = json['brand'];
  }
}
