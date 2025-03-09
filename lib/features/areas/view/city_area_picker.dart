// import 'package:atomshop/features/areas/controller/area_controller.dart';
// import 'package:atomshop/features/areas/model/area_model.dart';
// import 'package:atomshop/features/areas/model/city_model.dart';
// import 'package:atomshop/features/profile_feature/controller/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class CityDropdown extends StatelessWidget {
//   final ProfileController controller = Get.find<ProfileController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return DropdownButtonFormField<CityModel>(
//         decoration: InputDecoration(
//           labelText: "Select City",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         value: controller.selectedCity.value,
//         items: controller.cities.map((city) {
//           return DropdownMenuItem(value: city, child: Text(city.title));
//         }).toList(),
//         onChanged: (CityModel? newCity) {
//           if (newCity != null) {
//             controller.selectedCity.value = newCity;
//             controller.getAreasByCity(newCity.id);
//           }
//         },
//       );
//     });
//   }
// }


// class AreaDropdown extends StatelessWidget {
//   final ProfileController controller = Get.find<ProfileController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return DropdownButtonFormField<AreaModel>(
//         decoration: InputDecoration(
//           labelText: "Select Area",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         value: controller.selectedArea.value,
//         items: controller.areas.map((area) {
//           return DropdownMenuItem(value: area, child: Text(area.title));
//         }).toList(),
//         onChanged: (AreaModel? newArea) {
//           if (newArea != null) {
//             controller.selectedArea.value = newArea;
//           }
//         },
//       );
//     });
//   }
// }
