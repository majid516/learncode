import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/course.dart';

class AddSubCourseThumbnail extends StatefulWidget {
  AddSubCourseThumbnail({super.key});
  String? thumbnail;
 static  List<SubCourse>  subCourseList = [];
  
  @override
  State<AddSubCourseThumbnail> createState() => _AddSubCourseThumbnailState();
}

class _AddSubCourseThumbnailState extends State<AddSubCourseThumbnail> {
  final subCourseTitlecontroller = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
     subCourseTitlecontroller.dispose();
     AddSubCourseThumbnail.subCourseList.clear();
    AddSubCourseThumbnail.subCourseList.add(SubCourse(subCourseThumbnailPath: widget.thumbnail!, subCourseTitle: subCourseTitlecontroller.text));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pickImageFromGallery();
            },
            child: Container(
              width: ScreenSize.widthMed * 0.4,
              height: ScreenSize.widthMed * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                image: widget.thumbnail != null
                    ? DecorationImage(image: FileImage(File(widget.thumbnail!)), fit: BoxFit.cover)
                    : null,
              ),
              child: widget.thumbnail == null
                  ? const Center(
                      child: Text('image not selected'),
                    )
                  : null,
            ),
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.03,
          ),
          const Text(
            'add sub course thumbnail',
            style: addTutorialPagestyle,
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.05,
          ),
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
              controller: subCourseTitlecontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.03,
          ),
          const Text(
            'add sub course title',
            style: addTutorialPagestyle,
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.12,
          ),
        ],
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        widget.thumbnail = selectedImage.path;
      });
    }
  }
}
