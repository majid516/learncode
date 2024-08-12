import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/continue_btn.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';

class NameEnteringPage extends StatefulWidget {
  const NameEnteringPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NameEnteringPageState createState() => _NameEnteringPageState();
}

class _NameEnteringPageState extends State<NameEnteringPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  ImageProvider<Object>? image;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: ScreenSize.widthMed,
            height: ScreenSize.heightMed,
            decoration: const BoxDecoration(
              gradient: themePurple,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        image ?? const AssetImage('asset/image/userImage.jpeg'),
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Container(
                    width: ScreenSize.widthMed * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0x00D9D9D9).withOpacity(0.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: whiteColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter name',
                        hintStyle:
                            TextStyle(color: whiteColor.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ContinueButton(
                  title: 'Continue',
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      final userProfile =  image ??= const AssetImage("asset/image/userImage.jpeg");

                     final userDetails = UserDetails(userProfile: userProfile, userName: _nameController.toString());

                     addUserDetails(userDetails);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx) => UserHomeScreen(
                                  
                                )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        image = FileImage(File(selectedImage.path));
      });
    }
  }
}
