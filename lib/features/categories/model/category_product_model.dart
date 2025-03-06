class CategoryProductModel {
  int? id;
  String? title;
  String? price;
  String? picture;
  String? category;
  String? brand;

  CategoryProductModel(
      {this.id,
      this.title,
      this.price,
      this.picture,
      this.category,
      this.brand});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    picture = json['picture'];
    category = json['category'];
    brand = json['brand'];
  }
}
