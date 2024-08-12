import 'package:flutter/material.dart';
import 'package:learncode/modules/user_course_details_main_page.dart';
import 'package:learncode/screens/user/widgets/appbar_widget.dart';
import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class UserHomeScreen extends StatelessWidget {
  

  const UserHomeScreen({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: homeColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AppbarWidget(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        width: ScreenSize.widthMed,
                        color: homeColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                'Your Progerss',
                                style: tutorialPageTitletextStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(top: 20),
                              child: Center(
                                child: Container(
                                  width: ScreenSize.widthMed * 0.9,
                                  height: ScreenSize.heightMed * 0.3,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(141, 123, 123, 123),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 40, left: 30),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: ScreenSize.widthMed * 0.25,
                                              height:
                                                  ScreenSize.widthMed * 0.25,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 15,
                                                strokeCap: StrokeCap.round,
                                                value: .4,
                                                color: themeTextColor,
                                                backgroundColor: homeColor,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Completed',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const Text('43%',
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w800))
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 40),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                                width:
                                                    ScreenSize.widthMed * 0.42,
                                                child: LinearProgressIndicator(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  value: 0.5,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  color: Colors.red,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text('Web Designing'),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                height: 5,
                                                width:
                                                    ScreenSize.widthMed * 0.42,
                                                child: LinearProgressIndicator(
                                                  value: 0.5,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  color: Colors.red,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text('Mobile Devolopment'),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                height: 5,
                                                width:
                                                    ScreenSize.widthMed * 0.42,
                                                child: LinearProgressIndicator(
                                                  value: 0.5,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  color: Colors.red,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text('MERN stack')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Courses',
                                    style: tutorialPageTitletextStyle,
                                  ),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.search),
                                    label: const Text('Search'),
                                    style: TextButton.styleFrom(
                                      iconColor: themeTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          return Padding(
                              padding:const EdgeInsets.only(top: 25.0),
                              child: TutorialTileWidget(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const UserTutorialMainPageDetails(
                                        video:
                                            'asset/video/3195394-uhd_3840_2160_25fps.mp4',
                                        tutorialTitle: 'web designing',
                                        discription:
                                            'Web designing is the process of creating and organizing the visual layout and structure of websites. It involves designing the look and feel, including color schemes, fonts, images, and navigation, to ensure a user-friendly and visually appealing experience. Web designers use tools and techniques to build websites that are functional, responsive, and aligned with the needs of the target audience.',
                                      ),
                                    ),
                                  );
                                },
                              ));
                        },
                        childCount: 5,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
