import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learncode/buttons/enroll_now_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/course_add_functions.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/provider/enrolled_course_provider.dart';
import 'package:learncode/screens/user/widgets/success_enroll.dart';

class EnrollingAlert extends StatefulWidget {
  final Course course;
  final int courseId;
  final int progressPoint;
  final int totalPoint;
  const EnrollingAlert({
    super.key,
    required this.course,
    required this.courseId,
    required this.progressPoint,
    required this.totalPoint,
  });
  @override
  State<EnrollingAlert> createState() => _EnrollingAlertState();
}

class _EnrollingAlertState extends State<EnrollingAlert> {
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
          enrolledProvider.toggleEnrolledCourse(widget.course);
          addEnrolledCourse(widget.courseId);
          int playlistCount = AdminTutorialMainPageDetails.playlistCount;
          log('Enrolling with playlist count: $playlistCount');
          addProgress(widget.courseId, playlistCount);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const SuccessEnroll()),
          );
        })
      ],
    );
  }
}
