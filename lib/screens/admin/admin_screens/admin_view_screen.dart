import 'package:flutter/material.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AdminViewScreeen extends StatelessWidget {
  
   AdminViewScreeen({super.key , });
    
  
 
  @override
  Widget build(BuildContext context) {
    fechingCourseDetails();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: ScreenSize.widthMed,
              color: homeColor,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ValueListenableBuilder<List<Course>>(
            valueListenable: courseNotifier,
            builder: (context, courses, child) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    final courseData = courses[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TutorialTileWidget(
                        course: courseData, // Pass the course data here
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => AdminTutorialMainPageDetails(
                                courseImage: courseData.courseThumbnailPath,
                                index: index,
                                id:courseData.id!,
                                introVideo: courseData.courseDetails!.courseIntroductionVideo,
                                tutorialTitle: courseData.courseTitle,
                                description: courseData.courseDetails?.courseDescription ?? 'Description',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: courses.length,
                ),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
