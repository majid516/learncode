import 'package:flutter/material.dart';
import 'package:learncode/buttons/back_text_button.dart';
import 'package:learncode/buttons/next_text_button.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_course_thumbnail.dart';
import 'package:learncode/screens/admin/add_course/add_notes.dart';
import 'package:learncode/screens/admin/add_course/add_playlist_title.dart';
import 'package:learncode/screens/admin/add_course/add_sub_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_sub_couse_thumbnail.dart';

class AddNewCourse extends StatefulWidget {
  final VoidCallback onCourseAdded; // Add this callback

  AddNewCourse({super.key, required this.onCourseAdded}); // Make the callback required

  @override
  State<AddNewCourse> createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  final PageController controller = PageController();
  var currentIndex = 0;

  final _pages = [
    AddCourseThumbnail(),
    AddCourseDetails(),
    AddSubCourseThumbnail(),
    AddPlaylistTitle(),
    AddSubCourseDetails(),
    AddNotes()
  ];

  void _submitCourse() async {
    var courseS = Course(
      courseThumbnailPath: AddCourseThumbnail.thumbnail ??
          'asset/image/5 Tips To Create Awesome Slideshows.jpeg',
      courseTitle: AddCourseThumbnail.courseTitleController.text,
      courseDetails: CourseDetails(
        courseIntroductionVideo: AddCourseDetails.pickedVideo?.path ?? '',
        courseDescription: AddCourseDetails.courseDiscriptionController.text,
        subCourse: AddSubCourseThumbnail.subCourseList.map((value) {
          return SubCourse(
            subCourseTitle: value.subCourseTitle,
            subCourseThumbnailPath: value.subCourseThumbnailPath,
            tutorialPlayList: AddPlaylistTitle.playlistList.map((val) {
              return TutorialPlayList(
                playListTitle: val.playListTitle,
                subCourseDetails: SubCourseDetails(
                  subCourseVideo: AddSubCourseDetails.pickedVideo?.path ?? '',
                  questionNotes: QuestionNotes(questions: AddNotes.questionList, answers: AddNotes.answerList),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );

    await addNewCourse(courseS);

    showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        content: Text('New Course Added Successfully'),
      ),
    );

    // Call the callback function to change the selected index
    widget.onCourseAdded();

    // Optionally, reset the PageController to the first page
    controller.jumpToPage(0);
    setState(() {
      currentIndex = 0;
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
