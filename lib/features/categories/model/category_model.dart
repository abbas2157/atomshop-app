class CategoryModel {
  int? id;
  String? title;
  String? picture;
  String? categoryPicture;

  CategoryModel({this.id, this.title, this.picture, this.categoryPicture});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    picture = json['picture'];
    categoryPicture = json['picture'];
  }
}
