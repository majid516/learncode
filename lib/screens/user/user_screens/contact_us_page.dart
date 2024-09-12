import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    Future<void> sendEmail(String name, String email, String message) async {
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'leancodeapp@gmail.com',
        query:
            'subject=Contact from $name&body=Name: $name\nEmail: $email\nMessage: $message',
      );
      await launchUrl(params);
    }

    return SafeArea(
      child: Scaffold(
       
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                        iconColor: themeTextColor,
                        buttonColor: buttonGrey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const Text(
                      'Contact Us',
                      style: tutorialPageTitletextStyle,
                    ),
                    const SizedBox(
                      width: 60,
                    )
                  ],
                ),
              ),
                 const SizedBox(height: 50),
              const Text(
                "We'd love to hear from you! Please fill out the form below:",
                style: addTutorialPagestyle,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   SubmitButton(
                      onPressed: () {
                        final String name = nameController.text;
                        final String email = emailController.text;
                        final String message = messageController.text;
                   
                        // Validate fields before sending the email
                        if (name.isNotEmpty && message.isNotEmpty) {
                          sendEmail(name, email, message);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              margin: EdgeInsets.all(10),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Color.fromARGB(255, 252, 31, 15),
                                content: Text('Please fill out all fields')),
                          );
                        }
                      },
                     
                    ),
                 ],
               ),
             
            ],
          ),
        ),
      ),
    );
  }
}
