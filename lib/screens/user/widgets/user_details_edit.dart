import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/user_details.dart';

class UserDetailsEdit extends StatefulWidget {
  const UserDetailsEdit({super.key});

  static final nameController = TextEditingController();
  static String? userProfile;

  @override
  State<UserDetailsEdit> createState() => _UserDetailsEditState();
}

class _UserDetailsEditState extends State<UserDetailsEdit> {
  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        UserDetailsEdit.userProfile = selectedImage.path;
      });
    }
  }

  Future<void> _saveUserDetails() async {
    final userName = UserDetailsEdit.nameController.text;
    final userProfile = UserDetailsEdit.userProfile;

    if (userName.isNotEmpty && userProfile != null) {
      final userBox = await Hive.openBox<UserDetails>('UserDetails');
      await userBox.clear();
      await userBox
          .add(UserDetails(userName: userName, userProfile: userProfile));
      Navigator.of(context).pop();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: pickImageFromGallery,
              child: Container(
                width: ScreenSize.widthMed * 0.4,
                height: ScreenSize.widthMed * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  image: UserDetailsEdit.userProfile != null
                      ? DecorationImage(
                          image: FileImage(File(UserDetailsEdit.userProfile!)),
                          fit: BoxFit.fill,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Image not selected',
                    style: TextStyle(
                      color: UserDetailsEdit.userProfile == null
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: UserDetailsEdit.nameController,
              decoration: const InputDecoration(
                labelText: 'Admin Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SubmitButton(
              onPressed: _saveUserDetails,
            ),
          ],
        ),
      ),
    );
  }
}
