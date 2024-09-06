import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/buttons/enroll_button.dart';
import 'package:learncode/buttons/enroll_now_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/models/user_progress.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/provider/enrolled_course_provider.dart';
import 'package:learncode/screens/user/widgets/success_enroll.dart';

// class EnrollingAlert extends StatelessWidget {
//   final Course course;
//   final int courseId;
//   final int progressPoint;
//   final int totalPoint;
//   const EnrollingAlert({super.key, required this.course, required this.courseId, required this.progressPoint, required this.totalPoint});

//   @override
//   Widget build(BuildContext context) {
//     final enrolledProvider = EnrolledCourseProvider.of(context);
//     return AlertDialog(
//       title: const Text(
//         'enroll course',
//         style: tutorialPageTitletextStyle,
//       ),
//       content: const Text('confirm to enroll this course',
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text(
//               'cancel',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//             )),
//         EnrollNowButton(onPressed: () {
//           enrolledProvider.toggleEnrolledCourse(course);
//           addEnrolledCourse(courseId);
//           addProgress(courseId);
//         //  addUserProgress(UserProgress(courseId, progressPoint, totalPoint));
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (ctx) => const SuccessEnroll()),
//           );
//         })
//       ],
//     );
//   }
//   // Future<void> addUserProgress(UserProgress userProgress)async{
//   //  final progressBox = await Hive.openBox<UserProgress>('userProgress');
//   //  await progressBox.add(userProgress);
//   //     progressNotifier.notifyListeners();

//   // } 
// }
// // void getAllProgressBar() async {
// //     final box = await Hive.openBox('progressBox'); 
// //     final progressList = box.values
// //         .cast<UserProgress>() 
// //         .toList(); 
// //     progressNotifier.value = progressList.toList();
// //    progressNotifier.notifyListeners();

// // }
class EnrollingAlert extends StatelessWidget {
  final Course course;
  final int courseId;
  final int progressPoint;
  final int totalPoint;
  const EnrollingAlert({super.key, required this.course, required this.courseId, required this.progressPoint, required this.totalPoint});

  @override
  Widget build(BuildContext context) {
    final enrolledProvider = EnrolledCourseProvider.of(context);
    return AlertDialog(
      title: const Text(
        'Enroll Course',
        style: tutorialPageTitletextStyle,
      ),
      content: const Text('Confirm to enroll in this course',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            )),
        EnrollNowButton(onPressed: () {
          enrolledProvider.toggleEnrolledCourse(course);
          addEnrolledCourse(courseId);
          // Fetch the playlist count for the course
         int playlistCount = AdminTutorialMainPageDetails.playlistCount;
  log('Enrolling with playlist count: $playlistCount');
  addProgress(courseId, playlistCount);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const SuccessEnroll()),
          );
        })
      ],
    );
  }
}
