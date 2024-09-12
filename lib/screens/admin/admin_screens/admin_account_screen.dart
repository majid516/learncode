import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/admin_details.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/admin/admin_screens/reports_screen.dart';
import 'package:learncode/screens/admin/widgets/admin_details_edit.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';
import 'package:learncode/screens/user/widgets/account_card.dart';

import 'package:hive_flutter/hive_flutter.dart';

class AdminAccountScreen extends StatefulWidget {
  final UserDetails userDetails;

  const AdminAccountScreen({super.key, required this.userDetails});
  static AdminDetails? adminDetails;

  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen> {
  @override
  void initState() {
    super.initState();
    fetchAdminDetails();
  }

  Future<void> fetchAdminDetails() async {
    final adminBox = await Hive.openBox<AdminDetails>('AdminDetails');
    if (adminBox.isNotEmpty) {
      setState(() {
        AdminAccountScreen.adminDetails = adminBox.getAt(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;

            double nameBoxSize = isMobile
                ? constraints.maxWidth * 0.8
                : constraints.maxWidth * 0.4;

            return Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AdminAccountScreen
                                    .adminDetails?.adminProfile !=
                                null
                            ? FileImage(File(
                                AdminAccountScreen.adminDetails!.adminProfile!))
                            : const AssetImage('asset/image/user.jpeg')
                                as ImageProvider,
                      ),
                      const SizedBox(height: 20),
                      Container(
                          width: nameBoxSize,
                          height: 60,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadiusDirectional.circular(12),
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(95, 0, 0, 0),
                                    blurRadius: 10,
                                    offset: Offset(0, 2))
                              ]),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AdminAccountScreen.adminDetails?.adminName ??
                                      'Admin',
                                  style: accountPagetextStyle,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: themeTextColor, size: 27),
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (builder) =>
                                            const AdminDetailsEdit());

                                    fetchAdminDetails();
                                  },
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AccountCard(
                              titleText: 'reports',
                              icon: const Icon(
                                Icons.report_gmailerrorred,
                                color: themeTextColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const AdminReortPage()));
                              }),
                          AccountCard(
                              titleText: 'sign out',
                              icon: const Icon(
                                Icons.logout,
                                color: themeTextColor,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text(
                                          'signout',
                                          style: tutorialPageTitletextStyle,
                                        ),
                                        content: const Text(
                                          'are you sure signout',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'cancel',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                UserHomeScreen(
                                                                  userDetails: UserDetails(
                                                                      userName: widget
                                                                          .userDetails
                                                                          .userName,
                                                                      userProfile: widget
                                                                          .userDetails
                                                                          .userProfile),
                                                                )));
                                              },
                                              child: const Text(
                                                'signout',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ],
                                      );
                                    });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
