import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/admin/admin_screens/admin_login_screen.dart';
import 'package:learncode/screens/user/user_screens/user_account_page.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  late Box<UserDetails> userBox;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    userBox = await Hive.openBox<UserDetails>('UserDetails');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<UserDetails>('UserDetails').listenable(),
      builder: (context, Box<UserDetails> box, _) {
        if (box.isEmpty) {
          return const Center(
            child: Text(
              'No user details found',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        }
        final userDetails = box.values.first;
        return Container(
          width: ScreenSize.widthMed,
          height: ScreenSize.heightMed * 0.1,
          decoration: BoxDecoration(
              gradient: themePurple,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.3))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => AccountPage(
                                  userDetails: UserDetails(
                                      userName: userDetails.userName,
                                      userProfile: userDetails.userProfile),
                                )));
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: whiteColor,
                        size: 30,
                      ),
                    ),
                    CircleAvatar(
                      radius: 27,
                      backgroundImage: userDetails.userProfile.isNotEmpty
                          ? kIsWeb?MemoryImage(base64Decode(userDetails.userProfile)) 
                         : FileImage(File(userDetails.userProfile))
                          : const AssetImage(
                              'asset/image/userImage.jpeg',
                            ) as ImageProvider,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      userDetails.userName,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: whiteColor,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (ctx) => NamePage(
                          userDetails: UserDetails(
                              userName: userDetails.userName,
                              userProfile: userDetails.userProfile),
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    color: whiteColor,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
