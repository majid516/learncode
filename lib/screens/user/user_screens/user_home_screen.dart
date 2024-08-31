import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/widgets/appbar_widget.dart';
import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/screens/user/widgets/progress_card.dart';

class UserHomeScreen extends StatefulWidget {
  final String? name;

  final ImageProvider<Object>? userProfile;

  UserHomeScreen({
    super.key,
    this.name,
    this.userProfile,
  });

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // final int subCourseId;
  final _searchController = TextEditingController();

  List<Course> filterdList = [];
  @override
  void initState() {
    fechingCourseDetails();

    filterdList = courseNotifier.value;
    _searchController.addListener(() {
      filterCourse(_searchController.text);
    });
    // TODO: implement initState
    super.initState();
  }

  void filterCourse(String name) {
    final courses = courseNotifier.value;
    if (name.isEmpty) {
      setState(() {
        filterdList = courses;
      });
    } else {
      setState(() {
        filterdList = courses
            .where(
              (element) => element.courseTitle
                  .toLowerCase()
                  .contains(name.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: homeColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: AppbarWidget(
                    name: widget.name ?? '', userProfile: widget.userProfile),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Your Progress',
                        style: tutorialPageTitletextStyle,
                      ),
                    ),
                    const ProgressCard(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              prefixIcon: Icon(
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
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<List<Course>>(
              valueListenable: courseNotifier,
              builder: (context, courses, child) {
                final displayList =
                    filterdList.isEmpty && _searchController.text.isEmpty
                        ? courses
                        : filterdList;
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
                          course: courseData,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AdminTutorialMainPageDetails(
                                  course: courseData,
                                  isAdmin: false,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
