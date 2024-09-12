import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AdminViewScreeen extends StatefulWidget {
  const AdminViewScreeen({
    super.key,
  });

  @override
  State<AdminViewScreeen> createState() => _AdminViewScreeenState();
}

class _AdminViewScreeenState extends State<AdminViewScreeen> {
  final _searchController = TextEditingController();
  List<Course> filteredCourse = [];

  @override
  void initState() {
    filteredCourse = courseNotifier.value;

    _searchController.addListener(() {
      filterCourse(_searchController.text);
    });
    super.initState();
  }

  void filterCourse(String title) {
    final course = courseNotifier.value;
    if (title.isEmpty) {
      setState(() {
        filteredCourse = course;
      });
    } else {
      setState(() {
        filteredCourse = course
            .where(
              (element) => element.courseTitle
                  .toLowerCase()
                  .contains(title.toLowerCase()),
            )
            .toList();
      });
    }
  }

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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Courses',
                          style: tutorialPageTitletextStyle,
                        ),
                        AnimSearchBar(
                            color: Colors.transparent,
                            boxShadow: false,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: themeTextColor,
                            ),
                            rtl: true,
                            helpText: 'Search Course...',
                            width: ScreenSize.widthMed * 0.68,
                            textController: _searchController,
                            onSuffixTap: () {},
                            onSubmitted: (String s) {
                              _searchController.clear();
                            }),
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
              final displayList =
                  filteredCourse.isEmpty && _searchController.text.isEmpty
                      ? courses
                      : filteredCourse;

              if (courses.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      height: ScreenSize.heightMed * 0.4,
                      child: const Center(
                        child: Text(
                          "No Available Courses",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (displayList.isEmpty) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    width: ScreenSize.widthMed,
                    height: ScreenSize.heightMed * 0.6,
                    child: const Center(
                      child: Text(
                        'No items found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      final courseData = displayList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TutorialTileWidget(
                          course: courseData, // Pass the course data here
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AdminTutorialMainPageDetails(
                                  course: courseData,
                                  isAdmin: true,
                                  courseImage: courseData.courseThumbnailPath,
                                  index: index,
                                  id: courseData.id!,
                                  introVideo: courseData
                                      .courseDetails!.courseIntroductionVideo,
                                  tutorialTitle: courseData.courseTitle,
                                  description: courseData
                                          .courseDetails?.courseDescription ??
                                      'Description',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    childCount: displayList.length,
                  ),
                );
              }
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
