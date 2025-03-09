import 'package:atomshop/features/areas/model/area_model.dart';
import 'package:atomshop/features/areas/model/city_model.dart';

class UserModel {
  final int id;
  final String uuid;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.phone,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      uuid: json['uuid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],

    );
  }
}





class CustomerModel {
  final int id;
  final String? address;
  final int cityId;
  final int areaId;
  final CityModel? city;
  final AreaModel? area;

  CustomerModel({
    required this.id,
    this.address,
    required this.cityId,
    required this.areaId,
    this.city,
    this.area,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      address: json['address'],
      cityId: json['city_id'] ?? 0,
      areaId: json['area_id'] ?? 0,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      area: json['area'] != null ? AreaModel.fromJson(json['area']) : null,
    );
  }
}
