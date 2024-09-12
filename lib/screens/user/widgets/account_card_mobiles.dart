import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/screens/user/user_screens/favorite_page.dart';
import 'package:learncode/screens/user/user_screens/my_enrolled_course.dart';
import 'package:learncode/screens/user/user_screens/settings_page.dart';
import 'package:learncode/screens/user/user_screens/user_progress.dart';
import 'package:learncode/screens/user/widgets/account_card.dart';

class UserAccountCardsIsMobile extends StatelessWidget {
  const UserAccountCardsIsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AccountCard(
                titleText: 'enrollment',
                icon: const Icon(
                  Icons.layers,
                  color: themeTextColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const MyEnrolledCourses()));
                }),
            AccountCard(
                titleText: 'progress ',
                icon: const Icon(
                  Icons.auto_graph,
                  color: themeTextColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const UserProgressPage()));
                }),
            AccountCard(
                titleText: 'favorites',
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const FavoritePage()));
                }),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AccountCard(
                titleText: 'settings',
                icon: const Icon(
                  Icons.settings,
                  color: themeTextColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const SettingsPage()));
                }),
          ],
        ),
      ],
    );
  }
}