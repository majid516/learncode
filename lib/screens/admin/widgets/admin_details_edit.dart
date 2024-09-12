import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/admin_details.dart';

class AdminDetailsEdit extends StatefulWidget {
  const AdminDetailsEdit({super.key});

  static final courseTitleController = TextEditingController();
  static String? adminProfile;

  @override
  State<AdminDetailsEdit> createState() => _AdminDetailsEditState();
}

class _AdminDetailsEditState extends State<AdminDetailsEdit> {
  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        AdminDetailsEdit.adminProfile = selectedImage.path;
      });
    }
  }

  Future<void> _saveAdminDetails() async {
    final adminName = AdminDetailsEdit.courseTitleController.text;
    final adminProfile = AdminDetailsEdit.adminProfile;

    if (adminName.isNotEmpty && adminProfile != null) {
      final adminBox = await Hive.openBox<AdminDetails>('AdminDetails');
      await adminBox.clear(); 
      await adminBox.add(AdminDetails(adminName, adminProfile)); 
      Navigator.of(context).pop();
    }
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
                  image: AdminDetailsEdit.adminProfile != null
                      ? DecorationImage(
                          image: FileImage(File(AdminDetailsEdit.adminProfile!)),
                          fit: BoxFit.fill,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Image not selected',
                    style: TextStyle(
                      color: AdminDetailsEdit.adminProfile == null
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: AdminDetailsEdit.courseTitleController,
              decoration: const InputDecoration(
                labelText: 'Admin Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SubmitButton(
              onPressed: _saveAdminDetails,
             
            ),
          ],
        ),
      ),
    );
  }
}
