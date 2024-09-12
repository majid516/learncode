import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/user/user_screens/get_started_page.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';
import 'package:learncode/screens/user/widgets/appbar_widget.dart';

Future<void> addUserDetails(UserDetails value)async{
 final userBox = await Hive.openBox<UserDetails>('UserDetails');
  await userBox.add(value);
}

Future<void> checkUserDetails(BuildContext ctx) async {
  final userBox = await Hive.openBox<UserDetails>('UserDetails');
  if (userBox.isEmpty) {
    // ignore: use_build_context_synchronously
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx) => const GetStarted()));
  } else {
    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) =>const UserHomeScreen(
        ),
      ),
    );
  }
}

Future<void> getUser()async{
  final user = await Hive.openBox<UserDetails>('UserDetails');
  user.clear();
 AppbarWidget.userDataList.add(user.values.first.userName) ;
  AppbarWidget.userDataList.add(user.values.first.userProfile!) ;

}