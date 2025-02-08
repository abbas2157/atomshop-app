class CategoryModel {
  String name;
  String image;

  CategoryModel({required this.name, required this.image});
}

final List<CategoryModel> categories = [
  CategoryModel(name: 'Electronics', image: 'assets/images/phone.png'),
  CategoryModel(name: 'Fashion', image: 'assets/images/bag.png'),
  CategoryModel(name: 'Furniture', image: 'assets/images/furniture.png'),
  CategoryModel(name: 'Industrial', image: 'assets/images/car.png'),
  CategoryModel(name: 'Home Decor', image: 'assets/images/gift.png'),
  CategoryModel(name: 'Electronics', image: 'assets/images/tv.png'),
  CategoryModel(name: 'Health', image: 'assets/images/medicle.png'),
  CategoryModel(name: 'Fabrication Service', image: 'assets/images/foot.png'),
  CategoryModel(name: 'Electrical Equipment', image: 'assets/images/elec.png'),
  CategoryModel(name: 'Furniture', image: 'assets/images/furniture.png'),

];
