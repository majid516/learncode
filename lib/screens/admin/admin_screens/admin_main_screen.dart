import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/course_add_functions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/admin/add_course/add_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_course_thumbnail.dart';
import 'package:learncode/screens/admin/add_course/add_new_course.dart';
import 'package:learncode/screens/admin/admin_screens/admin_account_screen.dart';
import 'package:learncode/screens/admin/admin_screens/admin_view_screen.dart';
import 'package:learncode/screens/admin/widgets/admin_appabar_widget.dart';
import 'package:learncode/screens/web_screen/add_course_details_web.dart';

class AdminMainScreen extends StatefulWidget {
  final UserDetails userDetails;
  const AdminMainScreen({super.key, required this.userDetails});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int currentSelectedIndex = 0;

  void goToFirstPage() {
    setState(() {
      currentSelectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const AdminViewScreeen(),
      AddNewCourse(
        onCourseAdded: goToFirstPage,
        submitFuntion: () {
          if (AddCourseThumbnail.thumbnail != null &&
              AddCourseDetails.pickedVideo != null &&
              AddCourseDetails.courseDiscriptionController.text.isNotEmpty) {
            var course = Course(
              courseThumbnailPath: AddCourseThumbnail.thumbnail!,
              courseTitle: AddCourseThumbnail.courseTitleController.text,
              courseDetails: CourseDetails(
                courseIntroductionVideo: 
              
                   // ? AddCourseDetailsWeb.pickedVideo!.path
                     AddCourseDetails.pickedVideo!.path,
                courseDescription:
                    AddCourseDetails.courseDiscriptionController.text,
              ),
            );
            addNewCourse(course);
          } else {}
          return null;
        },
      ),
      AdminAccountScreen(
        userDetails: UserDetails(
            userName: widget.userDetails.userName,
            userProfile: widget.userDetails.userProfile),
      )
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AdminAppbarWidget(),
        backgroundColor: homeColor,
        body: screens[currentSelectedIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: themePurple,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(118, 0, 0, 0),
                offset: Offset(0, -2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GNav(
              selectedIndex: currentSelectedIndex,
              onTabChange: (value) {
                setState(() {
                  currentSelectedIndex = value;
                });
              },
              tabBackgroundColor: const Color.fromARGB(97, 222, 212, 212),
              tabBorderRadius: 30,
              activeColor: whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tabs: const [
                GButton(
                  gap: 5,
                  iconColor: whiteColor,
                  textColor: whiteColor,
                  icon: Icons.grid_4x4_outlined,
                  text: 'View',
                ),
                GButton(
                  gap: 5,
                  iconColor: whiteColor,
                  textColor: whiteColor,
                  icon: Icons.add_circle,
                  text: 'Add',
                ),
                GButton(
                  gap: 5,
                  iconColor: whiteColor,
                  textColor: whiteColor,
                  icon: Icons.account_circle_rounded,
                  text: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
