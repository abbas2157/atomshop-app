import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryDark,
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Ahmed Raza',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text('ahmedraza@gmail.com',
                style: TextStyle(color: Colors.white)),
            trailing: Icon(
              Icons.arrow_circle_right,
              color: Colors.white,
            ),
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
                    Text(
                      'Personal Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.local_shipping,
                              color: Colors.grey,
                            ),
                            title: Text('Shipping Address'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.payment,
                              color: Colors.grey,
                            ),
                            title: Text('Payment Method'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.history_edu,
                              color: Colors.grey,
                            ),
                            title: Text('Shipping Address'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ),
                    Text('Support & Information',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.shield,
                              color: Colors.grey,
                            ),
                            title: Text('Privacy Policy'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.description,
                              color: Colors.grey,
                            ),
                            title: Text('Terms And Conditions'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.info,
                              color: Colors.grey,
                            ),
                            title: Text('FAQs'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                    Text('Account Management',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 110,
                      child: ListView(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            title: Text('Change Password'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            dense: true,
                            leading: Icon(
                              Icons.phone_android,
                              color: Colors.grey,
                            ),
                            title: Text('Dark theme'),
                            trailing:
                                Switch(value: true, onChanged: (value) {}),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
