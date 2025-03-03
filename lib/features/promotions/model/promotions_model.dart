class PromotionsModel {
  String? picture;

  PromotionsModel({this.picture});

  PromotionsModel.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
  }
}
