import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';

class AdminAccountScreen extends StatelessWidget {
  final String? userName2;
  final ImageProvider<Object>? profileImage;
  const AdminAccountScreen({super.key,  this.userName2,  this.profileImage});

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
                              'Search tutorial',
                              style: accountPagetextStyle,
                            ),
                            Icon(
                              Icons.search,
                              color: themeTextColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>  UserHomeScreen()));
                      },
                      child: Container(
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
                                'Signout',
                                style: accountPagetextStyle,
                              ),
                              Icon(
                                Icons.logout,
                                color: themeTextColor,
                              )
                            ],
                          ),
                        ),
                      ),
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
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'about',
                              style: accountPagetextStyle,
                            ),
                            Icon(
                              Icons.info_outline,
                              color: themeTextColor,
                            )
                          ],
                        ),
                      ),
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
