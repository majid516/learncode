// import 'package:flutter/material.dart';
// import 'package:learncode/database/database_funtions.dart';
// import 'package:learncode/models/course.dart';
// import 'package:learncode/screens/user/widgets/appbar_widget.dart';
// import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/screens/user/widgets/progress_card.dart';

// import 'package:flutter/material.dart';
// import 'package:learncode/database/database_funtions.dart';
// import 'package:learncode/models/course.dart';
// import 'package:learncode/screens/user/widgets/appbar_widget.dart';
// import 'package:learncode/screens/user/widgets/courses_tile_widget.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/screens/user/widgets/progress_card.dart';

// class UserHomeScreen extends StatelessWidget {
//   final String? name;
//   final ImageProvider<Object>? userProfile;

//   const UserHomeScreen({
//     Key? key,
//     this.name,
//     this.userProfile,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: homeColor,
//         body: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 10.0),
//                 child: AppbarWidget(name: name ?? '', userProfile: userProfile),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 30),
//                       child: Text(
//                         'Your Progress',
//                         style: tutorialPageTitletextStyle,
//                       ),
//                     ),
//                     const ProgressCard(),
//                     const SizedBox(height: 30),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Courses',
//                             style: tutorialPageTitletextStyle,
//                           ),
//                           TextButton.icon(
//                             onPressed: () {},
//                             icon: const Icon(Icons.search),
//                             label: const Text('Search'),
//                             style: TextButton.styleFrom(
//                               iconColor: themeTextColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final courseData = courseNotifier.value[index];
//                   return TutorialTileWidget(
//                     course: Course(
//                       courseThumbnailPath: courseData.courseThumbnailPath,
//                       courseTitle: courseData.courseTitle,
//                     ),
//                     onPressed: () {},
//                   );
//                 },
//                 childCount: 0,
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: SizedBox(
//                 height: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
