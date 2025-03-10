import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/auth/change_password/change_password.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';
import 'package:atomshop/features/my_installments/view/installment_view.dart';
import 'package:atomshop/features/orders/view/my_orders.dart';
import 'package:atomshop/features/payments/view/payment_history.dart';
import 'package:atomshop/features/profile_feature/view/personal_info.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = AppUtils.isUserLoggedIn();
    return SafeArea(
      child: Container(
        color: AppColors.secondaryDark,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.white),
              title: Text(
                LocalStorageMethods.instance.getUserName() ?? "Username",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                  LocalStorageMethods.instance.getUserEmail() ?? "Email",
                  style: TextStyle(color: Colors.white)),
              // trailing: Icon(
              //   Icons.arrow_circle_right,
              //   color: Colors.white,
              // ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                width: double.infinity,
                //color: AppColors.secondaryDark,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Management',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      if (isUserLoggedIn) ...[
                        BuildMenuItem(
                            title: 'My Profile',
                            icon: Icons.person_outline,
                            onTap: () {
                              Get.to(() => PersonalInfo());
                            }),
                        BuildMenuItem(
                          title: 'My Orders',
                          icon: Icons.shopping_bag_outlined, // Updated icon
                          onTap: () {
                            Get.to(() => OrderHistoryScreen());
                          },
                        ),
                        BuildMenuItem(
                          title: 'My Installments',
                          icon: Icons
                              .payments_outlined, // Represents payments or installments
                          onTap: () {
                            Get.to(() => InstallmentHistoryScreen());
                          },
                        ),
                        BuildMenuItem(
                          title: 'Payment History',
                          icon: Icons
                              .receipt_long_outlined, // Represents transaction records or payment history
                          onTap: () {
                              Get.to(() => PaymentHistoryScreen());
                          },
                        ),
                        BuildMenuItem(
                          title: 'Change Password',
                          icon: Icons
                              .vpn_key_outlined, // Represents passwords and keys
                          onTap: () {
                            Get.to(() => ChangePasswordScreen());
                          },
                        ),
                      ],
                      BuildMenuItem(
                        title: isUserLoggedIn ? 'Logout' : 'Login',
                        icon: isUserLoggedIn ? Icons.logout : Icons.login,
                        onTap: isUserLoggedIn
                            ? () {
                                showLogoutDialog(context, () {
                                  // Handle logout logic
                                  LocalStorageMethods.instance
                                      .clearLocalStorage();
                                  final BottomNavController controller =
                                      Get.put(BottomNavController());
                                  controller.changePage(0);
                                  showToastMessage("Logout successfully");
                                }); // Show confirmation dialog
                              }
                            : () {
                                // Handle login/logout logic
                                Get.to(() => LoginScreen());
                              },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildMenuItem extends StatelessWidget {
  const BuildMenuItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  final Function() onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent, // Ensures the background remains unchanged
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
                8), // Optional: Adds smooth corners to ripple effect
            // ignore: deprecated_member_use
            splashColor: AppColors.secondaryDark
                // ignore: deprecated_member_use
                .withOpacity(0.1), // Custom splash color
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              dense: true,
              leading: Icon(icon, color: Colors.grey),
              title: Text(title),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
