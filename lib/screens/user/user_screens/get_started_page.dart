import 'package:flutter/material.dart';
import 'package:learncode/buttons/get_start_btn.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/user/user_screens/name_entering_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenSize.widthMed,
        height: ScreenSize.heightMed,
        decoration: const BoxDecoration(
          gradient: themePurple,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  width: ScreenSize.widthMed * 0.8,
                  child: Image.asset(
                      'asset/image/Free Photo _ Man wearing t shirt gesturing.png')),
              Container(
                width: ScreenSize.widthMed * 0.85,
                height: ScreenSize.widthMed * 0.7,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(161, 1, 1, 1),
                          blurRadius: 4,
                          offset: Offset(0, 3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Text(
                        'Develop  your skills in new and unique way !',
                        style: tutorialPageTitletextStyle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Transform your potential into achievement through online learning... ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ScreenSize.heightMed * 0.07,
                      ),
                      GetStartButton(
                          title: 'Get Started',
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => NameEnteringPage()));
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
