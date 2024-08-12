import 'package:flutter/material.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AdminViewScreeen extends StatelessWidget {
  const AdminViewScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 15),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: ScreenSize.widthMed,
                    color: homeColor,
                    child: Column(
                      children: [
                      const  SizedBox(height: 15),
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
                                icon:const Icon(Icons.search),
                                label:const Text('Search'),
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
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TutorialTileWidget(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const AdminTutorialMainPageDetails(video: 'asset/video/3195394-uhd_3840_2160_25fps.mp4', tutorialTitle: 'web designing', discription: 'Web designing is the process of creating and organizing the visual layout and structure of websites. It involves designing the look and feel, including color schemes, fonts, images, and navigation, to ensure a user-friendly and visually appealing experience. Web designers use tools and techniques to build websites that are functional, responsive, and aligned with the needs of the target audience.')));

                        },),
                      );
                    },
                    childCount: 9,
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
        );
  }
}
