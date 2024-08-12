import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddNewC extends StatefulWidget {
  AddNewC({super.key});

  @override
  State<AddNewC> createState() => _AddNewCState();
}

class _AddNewCState extends State<AddNewC> {
  ImageProvider<Object>? thumbnail;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          SizedBox(
            height: ScreenSize.heightMed * 0.1,
          ),
          InkWell(
            onTap: () {
              pickImageFromGallery();
            },
            child: Container(
              width: ScreenSize.widthMed * 0.4,
              height: ScreenSize.widthMed * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeTextColor,
            ),
          ),
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
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
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
        thumbnail = FileImage(File(selectedImage.path));
      });
    }
  }
}
