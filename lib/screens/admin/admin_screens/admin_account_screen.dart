import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';
import 'package:learncode/screens/user/widgets/account_card.dart';

class AdminAccountScreen extends StatelessWidget {
  const AdminAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('asset/image/user.jpeg'),
                        ),
                        Positioned(
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
                                color: Color.fromARGB(95, 0, 0, 0),
                                blurRadius: 10,
                                offset: Offset(0, 2))
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'admin',
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
                            titleText: 'search',
                            icon:const Icon(
                              Icons.search,
                              color: themeTextColor,
                            ),
                            onPressed: () {}),
                        AccountCard(
                            titleText: 'sign out',
                            icon:const Icon(
                              Icons.logout,
                              color: themeTextColor,
                            ),
                            onPressed: () {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (ctx) =>const UserHomeScreen()));
                            }),
                        AccountCard(
                            titleText: 'about',
                            icon:const Icon(
                              Icons.info_outline,
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
      ),
    );
  }
}
