import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

import 'package:learncode/screens/user/widgets/account_card.dart';

class AccountPage extends StatelessWidget {
  final String name;
  final ImageProvider<Object> userProfile;
  const AccountPage({
    super.key,
    required this.name,
    required this.userProfile,
  });

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
                children: [
                  CustomBackButton(
                      iconColor: themeTextColor,
                      buttonColor: buttonGrey,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(
                    width: 80,
                  ),
                  const Text(
                    'LearnCode',
                    style: tutorialPageTitletextStyle,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: userProfile,
                      ),
                      const Positioned(
                          top: 110,
                          left: 105,
                          child: Icon(
                            Icons.movie_edit,
                            color: themeTextColor,
                            size: 27,
                          ))
                    ],
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
                      padding:  EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: accountPagetextStyle,
                          ),
                           Icon(
                            Icons.edit,
                            color: themeTextColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AccountCard(
                          titleText: 'favourites',
                          icon:const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {}),
                      AccountCard(
                          titleText: 'enrollment',
                          icon:const Icon(
                            Icons.layers,
                            color: themeTextColor,
                          ),
                          onPressed: () {}),
                      AccountCard(
                          titleText: 'watched ',
                          icon:const Icon(
                            Icons.remove_red_eye_outlined,
                            color: themeTextColor,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                const  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AccountCard(
                          titleText: 'search ',
                          icon:const Icon(
                            Icons.search,
                            color: themeTextColor,
                          ),
                          onPressed: () {}),
                      AccountCard(
                          titleText: 'about',
                          icon:const Icon(
                            Icons.info_outline,
                            color: themeTextColor,
                          ),
                          onPressed: () {}),
                      AccountCard(
                          titleText: 'report',
                          icon:const Icon(
                            Icons.report_rounded,
                            color: themeTextColor,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
