import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';

class UpdateSubCourseTitle extends StatefulWidget {
  final String subcourseImage;
  final String subTitle;
  final int subIndex;

  const UpdateSubCourseTitle({
    super.key,
    required this.subcourseImage,
    required this.subTitle,
    required this.subIndex,
  });

  @override
  State<UpdateSubCourseTitle> createState() => _UpdateSubCourseTitleState();
}

class _UpdateSubCourseTitleState extends State<UpdateSubCourseTitle> {
  final ImagePicker picker = ImagePicker();

  String? updatedThumbnail;
  final subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    subTitleController.text = widget.subTitle;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: pickImageFromGallery,
            child: Container(
              width: ScreenSize.widthMed * 0.4,
              height: ScreenSize.widthMed * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: updatedThumbnail != null
                      ? FileImage(File(updatedThumbnail!))
                      : FileImage(File(widget.subcourseImage)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenSize.heightMed * 0.03),
          const Text(
            'Add Sub Course Thumbnail',
            style: addTutorialPagestyle,
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
              controller: subTitleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Enter Sub Course Title',
              ),
            ),
          ),
          SizedBox(height: ScreenSize.heightMed * 0.02),
          const Text(
            'Add Sub Course Thumbnail',
            style: addTutorialPagestyle,
          ),
          SizedBox(height: ScreenSize.heightMed * 0.04),
          SubmitButton(onPressed: () {
            final thumbnailToUpdate = updatedThumbnail ?? widget.subcourseImage;
            updateSubCourseTitle(
              widget.subIndex,
              thumbnailToUpdate,
              subTitleController.text,
            );
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        updatedThumbnail = selectedImage.path;
      });
    }
  }
}
