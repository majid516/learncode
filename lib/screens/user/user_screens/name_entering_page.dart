// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:learncode/buttons/continue_btn.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/database/user_details_db.dart';
// import 'package:learncode/models/user_details.dart';
// import 'package:learncode/screens/user/user_screens/user_home_screen.dart';

// class NameEnteringPage extends StatefulWidget {
//   const NameEnteringPage({super.key});

//   @override
//   _NameEnteringPageState createState() => _NameEnteringPageState();
// }

// class _NameEnteringPageState extends State<NameEnteringPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   String? image;
//   final ImagePicker picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             width: ScreenSize.widthMed,
//             height: ScreenSize.heightMed,
//             decoration: const BoxDecoration(
//               gradient: themePurple,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     pickImageFromGallery();
//                   },
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundImage: image != null
//                         ? FileImage(File(image!))
//                         : const AssetImage('asset/image/userImage.jpeg'),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Form(
//                   key: _formKey,
//                   child: Container(
//                     width: ScreenSize.widthMed * 0.8,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: const Color(0x00D9D9D9).withOpacity(0.35),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: TextFormField(
//                       controller: _nameController,
//                       style: const TextStyle(color: whiteColor),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Enter name',
//                         hintStyle:
//                             TextStyle(color: whiteColor.withOpacity(0.6)),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 16),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ContinueButton(
//                   title: 'Continue',
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       final userDetails = UserDetails(
//                         userName: _nameController.text,
//                         userProfile: image ?? 'asset/image/userImage.jpeg',
//                       );
//                       await addUserDetails(userDetails);
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (ctx) => UserHomeScreen(
//                             userDetails: UserDetails(
//                                 userName: userDetails.userName,
//                                 userProfile: userDetails.userProfile),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> pickImageFromGallery() async {
//     final XFile? selectedImage =
//         await picker.pickImage(source: ImageSource.gallery);
//     if (selectedImage != null) {
//       setState(() {
//         image = selectedImage.path;
//       });
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/continue_btn.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/user_details_db.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/screens/user/user_screens/user_home_screen.dart';

class NameEnteringPage extends StatefulWidget {
  const NameEnteringPage({super.key});

  @override
  _NameEnteringPageState createState() => _NameEnteringPageState();
}

class _NameEnteringPageState extends State<NameEnteringPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? image;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;

            double avatarRadius = isMobile ? 60 : 100;
            double containerWidth = isMobile
                ? constraints.maxWidth * 0.8
                : constraints.maxWidth * 0.5;

            return SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
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
                        radius: avatarRadius,

                        backgroundImage: image != null
                            ? (kIsWeb
                                ? MemoryImage(base64Decode(image!)) 
                                : FileImage(File(image!))) 
                            : const AssetImage(
                                'asset/image/userImage.jpeg'), 
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: containerWidth,
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final userDetails = UserDetails(
                            userName: _nameController.text,
                            userProfile: image ?? 'asset/image/userImage.jpeg',
                          );
                          await addUserDetails(userDetails);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => UserHomeScreen(
                                userDetails: UserDetails(
                                  userName: userDetails.userName,
                                  userProfile: userDetails.userProfile,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
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
          image = base64Encode(imageBytes);
        });
      } else {
        setState(() {
          image = selectedImage.path;
        });
      }
    }
  }
}
