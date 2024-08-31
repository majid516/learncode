import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/user/provider/enrolled_course_provider.dart';
import 'package:learncode/screens/user/provider/favourite_provider.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=> FavouriteProvider()),
        ChangeNotifierProvider(create: (ctx)=> EnrolledCourseProvider())
      ],
      child: MaterialApp(
        color: blackColor,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'MyCustomFont',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
       home: UserHomeScreen(),
      // home:const AdminMainScreen(),
      //home:const SplashScreenPage() ,
      ),
    );
  }
}
