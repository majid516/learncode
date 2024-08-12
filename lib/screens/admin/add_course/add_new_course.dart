import 'package:flutter/material.dart';
import 'package:learncode/buttons/back_text_button.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/admin/add_course/add_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_course_thumbnail.dart';
import 'package:learncode/screens/admin/add_course/add_notes.dart';
import 'package:learncode/screens/admin/add_course/add_sub_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_sub_couse_thumbnail.dart';


class AddNewCourse extends StatefulWidget {
  AddNewCourse({super.key});

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
    AddSubCourseDetails(),
    AddNotes()
  ];

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
                  offset: const Offset(0, 5)),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Column(
            children: [
              SizedBox(
            height: ScreenSize.heightMed * 0.012,
          ),
          const Row(
            children: [
              SizedBox(width: 20,),
              Text(
                'add new course',
                style: tutorialPageTitletextStyle,
              ),
            ],
          ),
          SizedBox(height: ScreenSize.heightMed*0.02,),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value){
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
                    BackTextButton(onPressed: () {
                      controller.jumpToPage(currentIndex - 1 );
                    }),
                    SubmitButton(onPressed: () {
                      if(currentIndex != _pages.length-1){
                        controller.jumpToPage(currentIndex + 1);
                      }else{
                        showDialog(context: context, builder: (ctx)=> AlertDialog(
                          
                          content: Text('New Course Added Successfully'),

                        ));
                      }
                    }),
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
