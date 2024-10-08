import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/models/user_details.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';
import 'package:learncode/screens/user/user_screens/user_progress.dart';
import 'package:learncode/screens/user/widgets/appbar_widget.dart';
import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/screens/user/widgets/progress_card.dart';

class UserHomeScreen extends StatefulWidget {
  final UserDetails? userDetails;
  const UserHomeScreen({
    super.key,
    this.userDetails,
  });

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _searchController = TextEditingController();
  final ProgressService _progressService = ProgressService();

  List<Course> filterdList = [];

  @override
  void initState() {
    _progressService.count();
    progressNotifier.addListener(_updateCount);
    _progressService.getCompletedPlaylist();
    fechingCourseDetails();
    fechPlaylist();
    printAllProgress();

    filterdList = courseNotifier.value;
    _searchController.addListener(() {
      filterCourse(_searchController.text);
    });
    super.initState();
  }

  void _updateCount() {
    setState(() {
      _progressService.count();
    });
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
            const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: AppbarWidget()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
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
                            autoFocus: true,
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
                            },
                          ),
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
                if (displayList.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      width: ScreenSize.widthMed,
                      height: ScreenSize.widthMed * 0.4,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kIsWeb? 3: 2,
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
                                  builder: (ctx) =>
                                      AdminTutorialMainPageDetails(
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
