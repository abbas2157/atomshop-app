import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/profile_feature/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalInfo extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        nameController.text = controller.name.value;
        phoneController.text = controller.phone.value;
        emailController.text = controller.email.value;
        addressController.text = controller.address.value;

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableText("Name").alignTopLeft(),
              ReusableTextField(
                labelText: "Name",
                hintText: "Enter your name",
                isPassword: false,
                controller: nameController,
              ),
              SizedBox(height: 10.h),
              lableText("Phone").alignTopLeft(),
              ReusableTextField(
                labelText: "Phone",
                hintText: "Enter your phone",
                isPassword: false,
                controller: phoneController,
              ),
              SizedBox(height: 10.h),
              lableText("Email").alignTopLeft(),
              ReusableTextField(
                labelText: "Email",
                hintText: "Enter your email",
                isPassword: false,
                controller: emailController,
              ),
              SizedBox(height: 10.h),
              lableText("Address").alignTopLeft(),
              ReusableTextField(
                labelText: "Address",
                hintText: "Enter your address",
                isPassword: false,
                controller: addressController,
              ),
              SizedBox(height: 10.h),
              lableText("City").alignTopLeft(),
              ReusableDropdown(
                items: controller.cities,
                selectedItem: controller.selectedCity,
                onChanged: (newValue) {
                  controller.selectedCity.value = newValue;
                  controller.getAreasByCity(newValue["id"]);
                },
              ),
              SizedBox(height: 10.h),
              lableText("Area").alignTopLeft(),
              ReusableDropdown(
                items: controller.areas,
                selectedItem: controller.selectedArea,
                onChanged: (newValue) {
                  controller.selectedArea.value = newValue;
                },
              ),
              SizedBox(height: 40.h),
              CommonButton(
                text: "Update Profile",
                onPressed: () => controller.updateProfile(
                    inputname: nameController.text,
                    inputphone: phoneController.text,
                    inputadress: addressController.text,
                    inputemail: emailController.text),
              ),
            ],
          ),
        );
      }),
    );
  }
}

//======================= CUSTOM DROPDOWN WIDGET =======================//
class ReusableDropdown extends StatelessWidget {
  final List<dynamic> items;
  final RxMap selectedItem;
  final Function(dynamic) onChanged;

  const ReusableDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<dynamic>(
          isExpanded: true,
          value: items.firstWhereOrNull((e) => e['id'] == selectedItem['id']),
          items: items.map<DropdownMenuItem<dynamic>>((item) {
            return DropdownMenuItem<dynamic>(
              value: item,
              child: Text(item['title']),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ));
  }
}
