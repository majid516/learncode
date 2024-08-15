import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddCourseThumbnail extends StatefulWidget {
  AddCourseThumbnail({super.key});
  static final courseTitleController = TextEditingController();
  static String? thumbnail;
  @override
  State<AddCourseThumbnail> createState() => _AddCourseThumbnailState();
}

class _AddCourseThumbnailState extends State<AddCourseThumbnail> {
  
  final ImagePicker picker = ImagePicker();

  // final v = FileImage(AddCourseThumbnail.thumbnail);

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
                image: AddCourseThumbnail.thumbnail != null
                    ? DecorationImage(image: FileImage(File(AddCourseThumbnail.thumbnail!)), fit: BoxFit.fill)
                    : null,
              ),
              child: AddCourseThumbnail.thumbnail == null
                  ? const Center(
                      child: Text(
                        'Image not selected',
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.03,
          ),
          const Text(
            'add course thumbnail',
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
              controller: AddCourseThumbnail.courseTitleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.03,
          ),
          const Text(
            'add course title',
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
        AddCourseThumbnail.thumbnail = selectedImage.path;
      });
    }
  }
}
