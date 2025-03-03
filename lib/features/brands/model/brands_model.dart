class BrandsModel {
  int? id;
  String? title;
  String? slug;
  String? picture;
  int? prCount;

  BrandsModel({this.id, this.title, this.slug, this.picture, this.prCount});

  BrandsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    picture = json['picture'];
    prCount = json['pr_count'];
  }
}
