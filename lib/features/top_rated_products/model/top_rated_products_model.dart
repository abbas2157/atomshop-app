
class TopRatedProductsModel {
  int? id;
  String? title;
  String? slug;
  String? price;
  String? picture;
  String? category;
  String? brand;

  TopRatedProductsModel(
      {this.id,
      this.title,
      this.slug,
      this.price,
      this.picture,
      this.category,
      this.brand});

  TopRatedProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    picture = json['picture'];
    category = json['category'];
    brand = json['brand'];
  }
}
