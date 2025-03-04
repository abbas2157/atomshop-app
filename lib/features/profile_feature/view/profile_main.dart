import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/utils/utils.dart';

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
              leading: Icon(Icons.person),
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
                      // Text(
                      //   'Personal Information',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 0.0, vertical: 0.0),
                      //   dense: true,
                      //   leading: Icon(
                      //     Icons.local_shipping,
                      //     color: Colors.grey,
                      //   ),
                      //   title: Text('Shipping Address'),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      // ),
                      // Divider(),
                      // Text('Support & Information',
                      //     style: TextStyle(fontWeight: FontWeight.bold)),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 0.0, vertical: 0.0),
                      //   dense: true,
                      //   leading: Icon(
                      //     Icons.shield,
                      //     color: Colors.grey,
                      //   ),
                      //   title: Text('Privacy Policy'),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      // ),
                      // Divider(),
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 0.0, vertical: 0.0),
                      //   dense: true,
                      //   leading: Icon(
                      //     Icons.description,
                      //     color: Colors.grey,
                      //   ),
                      //   title: Text('Terms And Conditions'),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      // ),
                      // Divider(),
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 0.0, vertical: 0.0),
                      //   dense: true,
                      //   leading: Icon(
                      //     Icons.info,
                      //     color: Colors.grey,
                      //   ),
                      //   title: Text('FAQs'),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      // ),
                      // Divider(),
                      Text('Account Management',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 0.0, vertical: 0.0),
                      //   dense: true,
                      //   leading: Icon(
                      //     Icons.lock,
                      //     color: Colors.grey,
                      //   ),
                      //   title: Text('Change Password'),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      // ),
                      // Divider(),
                      Material(
                        color: Colors
                            .transparent, // Ensures the background remains unchanged
                        child: InkWell(
                          onTap: isUserLoggedIn
                              ? () {
                                  showLogoutDialog(context, () {
                                    // Handle logout logic
                                    LocalStorageMethods.instance
                                        .clearLocalStorage();
                                  }); // Show confirmation dialog
                                }
                              : () {
                                  // Handle login/logout logic
                                  Get.to(() => LoginScreen());
                                },
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Adds smooth corners to ripple effect
                          // ignore: deprecated_member_use
                          splashColor: AppColors.secondaryDark
                              // ignore: deprecated_member_use
                              .withOpacity(0.1), // Custom splash color
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(isUserLoggedIn ?Icons.logout :Icons.login, color:isUserLoggedIn ? Colors.red: Colors.grey),
                            title: Text(isUserLoggedIn ? 'Logout' : 'Login'),
                          ),
                        ),
                      ),
                      Divider(),
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
