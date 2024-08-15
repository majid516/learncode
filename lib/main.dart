import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/admin/admin_screens/admin_main_screen.dart';
import 'package:learncode/constants/mediaquery.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
   // Register Hive adapters
   if (!Hive.isAdapterRegistered(CourseDetailsAdapter().typeId)) {
     Hive.registerAdapter(CourseDetailsAdapter()); 
   }
  if (!Hive.isAdapterRegistered(UserDetailsAdapter().typeId)) {
    Hive.registerAdapter(UserDetailsAdapter());
  }
  if (!Hive.isAdapterRegistered(CourseAdapter().typeId)) {
    Hive.registerAdapter(CourseAdapter());
  }
  if (!Hive.isAdapterRegistered(SubCourseAdapter().typeId)) {
    Hive.registerAdapter(SubCourseAdapter());
  }
  if (!Hive.isAdapterRegistered(TutorialPlayListAdapter().typeId)) {
    Hive.registerAdapter(TutorialPlayListAdapter());
  }
  if (!Hive.isAdapterRegistered(SubCourseDetailsAdapter().typeId)) {
    Hive.registerAdapter(SubCourseDetailsAdapter());
  }
  if (!Hive.isAdapterRegistered(QuestionNotesAdapter().typeId)) {
    Hive.registerAdapter(QuestionNotesAdapter());
  }

  runApp(const LearnCode());
}

class LearnCode extends StatelessWidget {
  const LearnCode({super.key});
 @override
  Widget build(BuildContext context) {
    ScreenSize.initialize(context);
    return MaterialApp(
      color: blackColor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MyCustomFont',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AdminMainScreen(),
     // home:const SplashScreenPage() ,
    );
  }
}
