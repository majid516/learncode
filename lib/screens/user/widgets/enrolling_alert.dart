import 'package:flutter/material.dart';
import 'package:learncode/buttons/enroll_button.dart';
import 'package:learncode/buttons/enroll_now_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/user/provider/enrolled_course_provider.dart';
import 'package:learncode/screens/user/widgets/success_enroll.dart';

class EnrollingAlert extends StatelessWidget {
  final Course course;
  final int courseId;
  const EnrollingAlert({super.key, required this.course, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final enrolledProvider = EnrolledCourseProvider.of(context);
    return AlertDialog(
      title: const Text(
        'enroll course',
        style: tutorialPageTitletextStyle,
      ),
      content: const Text('confirm to enroll this course',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'cancel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            )),
        EnrollNowButton(onPressed: () {
          enrolledProvider.toggleEnrolledCourse(course);
          addEnrolledCourse(courseId);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const SuccessEnroll()),
          );
        })
      ],
    );
  }
}
