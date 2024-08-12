
import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/user_details.dart';

class AccountPage extends StatelessWidget {
  final String name ;
  final ImageProvider<Object> userProfile;
  const AccountPage({super.key, required this.name, required this.userProfile, });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails?>(
      future: fechingUserDetails(), 
      builder: (ctx,index){
        if (index.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (index.hasError) {
          return const CircularProgressIndicator();
        }
        final userData = index.data;
      
      
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
                const  SizedBox(
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
                        backgroundImage:userData?.userProfile??AssetImage('asset/image/userImage.jpeg'),
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
                const  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: ScreenSize.widthMed * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadiusDirectional.circular(12),
                        border: Border.all(width: 0.2),
                        boxShadow: const[
                          BoxShadow(
                              color: Color.fromARGB(95, 0, 0, 0),
                              blurRadius: 10,
                              offset: Offset(0, 2))
                        ]),
                    child: Padding(
                      padding:const  EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userData?.userName??'User',
                            style: accountPagetextStyle,
                          ),
                          const Icon(
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
                        boxShadow:const [
                          BoxShadow(
                              color: Color.fromARGB(95, 0, 0, 0),
                              blurRadius: 10,
                              offset: Offset(0, 2))
                        ]),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'favourites',
                            style: accountPagetextStyle,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                    height: 20,
                  ),Container(
                    width: ScreenSize.widthMed * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadiusDirectional.circular(12),
                        border: Border.all(width: 0.2),
                        boxShadow: const[
                          BoxShadow(
                              color: Color.fromARGB(95, 0, 0, 0),
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child:const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        children: [
                          Text(
                            'my enrolled courses',
                            style: accountPagetextStyle,
                          ),
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
                        boxShadow: const[
                          BoxShadow(
                              color: Color.fromARGB(95, 0, 0, 0),
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child:const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        children: [
                          Text(
                            'watched tutorial',
                            style: accountPagetextStyle,
                          ),
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
                        boxShadow:const [
                          BoxShadow(
                              color: Color.fromARGB(95, 0, 0, 0),
                              blurRadius: 10,
                              offset: Offset(0, 2))
                        ]),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'search tutorial',
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
                  Container(
                    width: ScreenSize.widthMed * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadiusDirectional.circular(12),
                        border: Border.all(width: 0.2),
                        boxShadow:const [
                          BoxShadow(
                              color: Color.fromARGB(95, 0, 0, 0),
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 35.0),
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
    );
      },
    );
  }
}
