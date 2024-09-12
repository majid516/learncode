import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: Row(
                      children: [
                        CustomBackButton(
                            iconColor: themeTextColor,
                            buttonColor: buttonGrey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        const SizedBox(
                          width: 80,
                        ),
                        const Text(
                          'About',
                          style: tutorialPageTitletextStyle,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "About Learn Code",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: themeTextColor),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome to Learn Code – your ultimate platform for learning programming at your own pace. We provide a comprehensive collection of courses designed to help you build and sharpen your coding skills. Whether you're a beginner or an advanced coder, Learn Code offers free access to a variety of topics and resources to suit your learning needs.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Our structure is simple:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: themeTextColor),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "• Courses: Each course comes with an introductory video, a detailed description, and sub-courses to dive deeper into specific topics.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    "• Sub-Courses: Explore focused sub-courses, each offering curated playlists to guide you through step-by-step tutorials.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    "• Playlists: Learn from high-quality video tutorials. Each playlist is accompanied by questions and answers to reinforce your learning.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    "• Notes: Take advantage of additional resources and Q&A to help clarify concepts and enhance understanding.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "What sets Learn Code apart is that all courses are completely free! You can enroll in as many courses as you like and track your progress as you advance through the material.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Start learning today, unlock your potential, and track your journey – all for free, only on Learn Code!",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
