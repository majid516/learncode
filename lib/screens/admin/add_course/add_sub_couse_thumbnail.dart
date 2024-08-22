import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/admin_screens/admin_main_screen.dart';

class AddSubCourseThumbnail extends StatefulWidget {
  final int indexCourse;
  
  final String courseNamee ;
  final Course course; // Fixed typo from 'cource' to 'course'
  AddSubCourseThumbnail({super.key, required this.indexCourse, required this.course,  required this.courseNamee});

  @override
  _AddSubCourseThumbnailState createState() => _AddSubCourseThumbnailState();
}

class _AddSubCourseThumbnailState extends State<AddSubCourseThumbnail> {
  final subCourseTitleController = TextEditingController(); // Fixed typo from 'subCourseTitlecontroller' to 'subCourseTitleController'
  final ImagePicker picker = ImagePicker();
  String? thumbnail;
  List<Course> courseList = [];

  @override
  void dispose() {
    subCourseTitleController.dispose(); // Fixed typo here as well
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Sub Course Thumbnail')), // Added AppBar for better navigation context
      body: SingleChildScrollView(
        child: SizedBox(
          width: ScreenSize.widthMed,
          height: ScreenSize.heightMed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: pickImageFromGallery,
                child: Container(
                  width: ScreenSize.widthMed * 0.4,
                  height: ScreenSize.widthMed * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    image: thumbnail != null
                        ? DecorationImage(
                            image: FileImage(File(thumbnail!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: thumbnail == null
                      ? const Center(
                          child: Text('Image not selected'),
                        )
                      : null,
                ),
              ),
              SizedBox(height: ScreenSize.heightMed * 0.03),
              const Text(
                'Add Sub Course Thumbnail',
               // style: addTutorialPageStyle, // Fixed typo here from 'addTutorialPagestyle' to 'addTutorialPageStyle'
              ),
              SizedBox(height: ScreenSize.heightMed * 0.05),
              Container(
                width: ScreenSize.widthMed * 0.75,
                height: 60,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.circular(12),
                  border: Border.all(width: 0.2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(95, 0, 0, 0),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: subCourseTitleController, // Fixed typo here as well
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Enter Sub Course Title',
                  ),
                ),
              ),
              SizedBox(height: ScreenSize.heightMed * 0.03),
              const Text(
                'Add Sub Course Title',
             //   style: addTutorialPageStyle, // Fixed typo here
              ),
              SizedBox(height: ScreenSize.heightMed * 0.12),
              SubmitButton(
                onPressed: () {
                  if (thumbnail != null && subCourseTitleController.text.isNotEmpty) {
                    var subCourse = SubCourse(
                      courseName: widget.courseNamee,
                      subCourseThumbnailPath: thumbnail!,
                      subCourseTitle: subCourseTitleController.text,
                    );
                    addNewSubCourse(subCourse);
                 print(widget.courseNamee);
                   
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> AdminMainScreen()));

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please add a thumbnail and title.'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        thumbnail = selectedImage.path;
      });
    }
  }
  
}
