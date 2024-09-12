import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/user_details_db.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/admin/admin_screens/admin_login_screen.dart';
import 'package:learncode/screens/user/user_screens/user_account_page.dart';

class AppbarWidget extends StatelessWidget {
   final UserDetails userDetails;
static final userDataList = [];
 const AppbarWidget({
    super.key, 
    required this.userDetails,
    
  });

  @override
  Widget build(BuildContext context) {

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
                            userDetails: UserDetails(userName: userDetails.userName,userProfile: userDetails.userProfile),
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
                    backgroundImage: userDetails.userProfile != null
                        ? FileImage(File(userDetails.userProfile!))
                        : const AssetImage('asset/image/userImage.jpeg') as ImageProvider,
  
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
                      builder: (ctx) =>  NamePage(userDetails: UserDetails(userName: userDetails.userName,userProfile: userDetails.userProfile),),
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
        ));
  }
}



