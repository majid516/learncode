import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/user/widgets/account_card_mobiles.dart';
import 'package:learncode/screens/user/widgets/user_account_card_web.dart';
import 'package:learncode/screens/user/widgets/user_details_edit.dart';

class AccountPage extends StatefulWidget {
  final UserDetails userDetails;
  const AccountPage({
    super.key,
    required this.userDetails,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late UserDetails userDetails;

  @override
  void initState() {
    super.initState();
    userDetails = widget.userDetails;
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final userBox = await Hive.openBox<UserDetails>('UserDetails');
    if (userBox.isNotEmpty) {
      setState(() {
        userDetails = userBox.getAt(0)!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                      iconColor: themeTextColor,
                      buttonColor: buttonGrey,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const Text(
                    'LearnCode',
                    style: tutorialPageTitletextStyle,
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      // ignore: unnecessary_null_comparison
                      backgroundImage: userDetails.userProfile != null
                          ? FileImage(File(userDetails.userProfile))
                          : const AssetImage('asset/image/userImage.jpeg')
                              as ImageProvider,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: ScreenSize.widthMed * 0.8,
                      height: 60,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadiusDirectional.circular(12),
                          border: Border.all(width: 0.2),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(48, 0, 0, 0),
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userDetails.userName,
                              style: accountPagetextStyle,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: themeTextColor, size: 27),
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (builder) =>
                                        const UserDetailsEdit());

                                fetchUserDetails();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isMobile
                        ? const UserAccountCardsIsMobile()
                        : const UserAccountCardsIsWeb()
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
