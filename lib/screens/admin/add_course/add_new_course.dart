import 'package:flutter/material.dart';
import 'package:learncode/buttons/back_text_button.dart';
import 'package:learncode/buttons/next_text_button.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

import 'package:learncode/screens/admin/add_course/add_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_course_thumbnail.dart';

// ignore: must_be_immutable
class AddNewCourse extends StatefulWidget {
  final VoidCallback onCourseAdded;

  int? Function() submitFuntion;
  AddNewCourse(
      {super.key,
      required this.onCourseAdded,
      required this.submitFuntion}); // Make the callback required

  @override
  State<AddNewCourse> createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  final PageController controller = PageController();
  var currentIndex = 0;

  final _pages = [
    const AddCourseThumbnail(),
    const AddCourseDetails(),
  ];

  void _submitCourse() async {
    void showErrorDialog(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 206, 34, 22),
          margin: const EdgeInsets.all(12),
          behavior: SnackBarBehavior.floating,
          content: Text(
            message,
            style: const TextStyle(color: whiteColor),
          )));
    }

    if (AddCourseThumbnail.courseTitleController.text.isEmpty) {
      showErrorDialog('title is requiered');
      return;
    }
    if (AddCourseDetails.courseDiscriptionController.text.isEmpty) {
      showErrorDialog('description is requiered');
      return;
    }
    if (AddCourseThumbnail.thumbnail == null) {
      showErrorDialog('thumbnail is requiered');
      return;
    }
    if (AddCourseDetails.pickedVideo == null) {
      showErrorDialog('video is requiered');
      return;
    }

    widget.submitFuntion();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'success',
          style: tutorialPageTitletextStyle,
        ),
        content: const Text('New Course Added Successfully'),
        actions: [
          TextButton(
              onPressed: () {
                widget.onCourseAdded();

                Navigator.of(ctx).pop();
              },
              child: const Text(
                'done',
                style: tutorialPageTitletextStyle,
              )),
        ],
      ),
    );

    controller.jumpToPage(0);
    setState(() {
      currentIndex = 0;
    });
    AddCourseDetails.courseDiscriptionController.clear();
    AddCourseThumbnail.courseTitleController.clear();
    setState(() {
      AddCourseThumbnail.thumbnail = null;
      AddCourseDetails.pickedVideo == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenSize.widthMed * 0.9,
        height: ScreenSize.heightMed * 0.74,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Column(
            children: [
              SizedBox(height: ScreenSize.heightMed * 0.012),
              const Row(
                children: [
                  SizedBox(width: 20),
                  Text('Add New Course', style: tutorialPageTitletextStyle),
                ],
              ),
              SizedBox(height: ScreenSize.heightMed * 0.02),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  controller: controller,
                  itemBuilder: (ctx, index) {
                    return _pages[index];
                  },
                  itemCount: _pages.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentIndex == 0
                        ? const Text('')
                        : BackTextButton(onPressed: () {
                            controller.jumpToPage(currentIndex - 1);
                          }),
                    currentIndex != _pages.length - 1
                        ? NextTextButton(onPressed: () {
                            controller.jumpToPage(currentIndex + 1);
                          })
                        : SubmitButton(
                            onPressed: () {
                              _submitCourse();
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
