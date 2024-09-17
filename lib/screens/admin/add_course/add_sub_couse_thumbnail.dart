import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/course_add_functions.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';

class AddSubCourseThumbnail extends StatefulWidget {
  final int indexCourse;
  final String courseNamee;
  final Course course;
  const AddSubCourseThumbnail(
      {super.key,
      required this.indexCourse,
      required this.course,
      required this.courseNamee});

  @override
  // ignore: library_private_types_in_public_api
  _AddSubCourseThumbnailState createState() => _AddSubCourseThumbnailState();
}

class _AddSubCourseThumbnailState extends State<AddSubCourseThumbnail> {
  final subCourseTitleController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String? thumbnail;
  List<Course> courseList = [];

  @override
  void dispose() {
    subCourseTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Add Sub Course Thumbnail',
        style: accountPagetextStyle,
      )),
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
                  width:kIsWeb?ScreenSize.widthMed * 0.25: ScreenSize.widthMed * 0.4,
                  height:kIsWeb?ScreenSize.widthMed * 0.17: ScreenSize.widthMed * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    image: thumbnail != null
                        ?(kIsWeb
                        ? DecorationImage(
                            image: MemoryImage(base64Decode(thumbnail!)),
                            fit: BoxFit.fill,
                          )
                        : DecorationImage(
                            image: FileImage(File(thumbnail!)),
                            fit: BoxFit.fill,
                          ))
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
                style: addTutorialPagestyle,
              ),
              SizedBox(height: ScreenSize.heightMed * 0.05),
              Container(
                width:kIsWeb?ScreenSize.widthMed * 0.5: ScreenSize.widthMed * 0.75,
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
                  controller: subCourseTitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Enter Sub Course Title',
                  ),
                ),
              ),
              SizedBox(height: ScreenSize.heightMed * 0.03),
              const Text(
                'Add Sub Course Title',
                style: addTutorialPagestyle,
              ),
              SizedBox(height: ScreenSize.heightMed * 0.12),
              SubmitButton(
                onPressed: () {
                  if (thumbnail != null &&
                      subCourseTitleController.text.isNotEmpty) {
                    var subCourse = SubCourse(
                      courseId: widget.course.id!,
                      subCourseThumbnailPath: thumbnail!,
                      subCourseTitle: subCourseTitleController.text,
                    );
                    addNewSubCourse(subCourse);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color.fromARGB(255, 192, 32, 21),
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
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      if (kIsWeb) {
        var imageBytes = await selectedImage.readAsBytes();
        setState(() {
        thumbnail = base64Encode(imageBytes);
        });
      } else {
      setState(() {
        thumbnail = selectedImage.path;
      });
      }
    }
  }
}
