// import 'package:flutter/material.dart';
// import 'package:learncode/buttons/get_start_btn.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/screens/user/user_screens/name_entering_page.dart';

// class GetStarted extends StatelessWidget {
//   const GetStarted({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: ScreenSize.widthMed,
//         height: ScreenSize.heightMed,
//         decoration: const BoxDecoration(
//           gradient: themePurple,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                   width: ScreenSize.widthMed * 0.8,
//                   child: Image.asset(
//                       'asset/image/Free Photo _ Man wearing t shirt gesturing.png')),
//               Container(
//                 width: ScreenSize.widthMed * 0.85,
//                 height: ScreenSize.widthMed * 0.7,
//                 decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Color.fromARGB(161, 1, 1, 1),
//                           blurRadius: 4,
//                           offset: Offset(0, 3))
//                     ]),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Develop  your skills in new and unique way !',
//                         style: tutorialPageTitletextStyle,
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       const Text(
//                         'Transform your potential into achievement through online learning... ',
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: ScreenSize.heightMed * 0.07,
//                       ),
//                       GetStartButton(
//                         title: 'Get Started',
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (ctx) => const NameEnteringPage(),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:learncode/buttons/get_start_btn.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/screens/user/user_screens/name_entering_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          double imageWidth = isMobile ? constraints.maxWidth * 0.7 : constraints.maxWidth * 0.3;
          double containerWidth = isMobile ? constraints.maxWidth * 0.85 : constraints.maxWidth * 0.4;
          double containerHeight = isMobile ? constraints.maxHeight * 0.3 : constraints.maxHeight * 0.35;
          double textFontSize = isMobile ? 15 : 20;

          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: const BoxDecoration(
              gradient: themePurple,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: imageWidth,
                    child: Image.asset(
                      'asset/image/Free Photo _ Man wearing t shirt gesturing.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.0),
                  Container(
                    width: containerWidth,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(161, 1, 1, 1),
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Develop your skills in new and unique way!',
                            style: tutorialPageTitletextStyle.copyWith(fontSize: textFontSize),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Transform your potential into achievement through online learning...',
                            style: TextStyle(
                              fontSize: textFontSize * 0.9,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: constraints.maxHeight * 0.03),
                          GetStartButton(
                            title: 'Get Started',
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const NameEnteringPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
