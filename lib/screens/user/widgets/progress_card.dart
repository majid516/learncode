// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/database/user_progress_db.dart';
// import 'package:learncode/screens/user/user_screens/user_progress.dart';

// // ignore: must_be_immutable

// class ProgressCard extends StatefulWidget {
//   const ProgressCard({
//     super.key,
//   });

//   @override
//   State<ProgressCard> createState() => _ProgressCardState();
// }

// int counts = 0;
// int totalCompletedPlaylist = 0;

// class _ProgressCardState extends State<ProgressCard> {
//   Future<void> getCompletedPlaylist() async {
//     int count = await countTotalCompletedPlaylists();
//     setState(() {
//       totalCompletedPlaylist = count;
//     });
//   }

//   Future<void> count() async {
//     int tempCount = 0;
//     for (var element in progressNotifier.value) {
//       tempCount += element.totalPoint;
//     }

//     setState(() {
//       counts = tempCount;
//     });
//   }

//   @override
//   void initState() {
     
//     count();
//     progressNotifier.addListener(count);
//     getCompletedPlaylist();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     progressNotifier.removeListener(count);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(top: 20),
//       child: Center(
//         child: Container(
//           width: ScreenSize.widthMed * 0.9,
//           height: ScreenSize.heightMed * 0.3,
//           decoration: BoxDecoration(
//             color: whiteColor,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color.fromARGB(141, 123, 123, 123),
//                 blurRadius: 4,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10, left: 30),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 30.0),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: ScreenSize.widthMed * 0.25,
//                         height: ScreenSize.widthMed * 0.25,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 15,
//                           strokeCap: StrokeCap.round,
//                           value: totalCompletedPlaylist == 0 || counts == 0
//                               ? 0
//                               : totalCompletedPlaylist / counts,
//                           color: themeTextColor,
//                           backgroundColor: homeColor,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         'Completed',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w700),
//                       ),
//                       Text(
//                         '$totalCompletedPlaylist / $counts',
//                         style: const TextStyle(
//                             fontSize: 19, fontWeight: FontWeight.w800),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 25),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemBuilder: (ctx, index) {
//                             final data = userProgressNotifier.value[index];
//                             final datas = progressNotifier.value[index];
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SizedBox(
//                                   width: ScreenSize.widthMed * 0.5,
//                                   height: ScreenSize.widthMed * 0.1,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             data.courseTitle,
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 12,
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                         width: ScreenSize.widthMed * 0.4,
//                                         child: LinearProgressIndicator(
//                                           value: datas.progressPoint /
//                                               datas.totalPoint,
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           backgroundColor: Colors.grey[300],
//                                           color: themeTextColor,
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             );
//                           },
//                           itemCount: progressNotifier.value.length>3?3:progressNotifier.value.length,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.of(context).push(CupertinoPageRoute(
//                                 builder: (ctx) => const UserProgressPage()));
//                           },
//                           child: const Text(
//                             'See more',
//                             style: TextStyle(
//                               color: themeTextColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/screens/user/user_screens/user_progress.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({super.key});

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  final ProgressService _progressService = ProgressService();

  @override
  void initState() {
    super.initState();
    _progressService.count();
    progressNotifier.addListener(_updateCount);
    _progressService.getCompletedPlaylist();
  }

  void _updateCount() {
    setState(() {
      _progressService.count();
    });
  }

  @override
  void dispose() {
    progressNotifier.removeListener(_updateCount);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
         bool isMobile = constraints.maxWidth < 600;

          double containerWidth = isMobile ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.8;
          double containerHieght= isMobile ? constraints.maxWidth * 0.5 : constraints.maxWidth * 0.3;
                  double progressHieght= isMobile ? constraints.maxWidth * 0.2 : constraints.maxWidth * 0.2;
          double progresswidth= isMobile ? constraints.maxWidth * 0.2 : constraints.maxWidth * 0.2;

      
    return  Padding(
        padding: const EdgeInsetsDirectional.only(top: 20),
        child: Center(
          child: Container(
            width:containerWidth,
            height: containerHieght,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(141, 123, 123, 123),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 30),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: progresswidth,
                          height: progressHieght,
                          child: CircularProgressIndicator(
                            strokeWidth: 15,
                            strokeCap: StrokeCap.round,
                            value: _progressService.totalCompletedPlaylist == 0 ||
                                    _progressService.counts == 0
                                ? 0
                                : _progressService.totalCompletedPlaylist /
                                    _progressService.counts,
                            color: themeTextColor,
                            backgroundColor: homeColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Completed',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${_progressService.totalCompletedPlaylist} / ${_progressService.counts}',
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: progressNotifier.value.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No progress available',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    final data =
                                        userProgressNotifier.value[index];
                                    final datas = progressNotifier.value[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: ScreenSize.widthMed * 0.5,
                                          height: ScreenSize.widthMed * 0.1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    data.courseTitle,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              SizedBox(
                                                height: 8,
                                                width:
                                                    ScreenSize.widthMed * 0.4,
                                                child: LinearProgressIndicator(
                                                  value: datas.progressPoint /
                                                      datas.totalPoint,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  color: themeTextColor,
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                  itemCount: progressNotifier.value.length > 3
                                      ? 3
                                      : progressNotifier.value.length,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (ctx) => const UserProgressPage()));
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                color: themeTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      }
    );
  }
}


class ProgressService {
  // Singleton instance
  static final ProgressService _instance = ProgressService._internal();
  factory ProgressService() {
    return _instance;
  }
  ProgressService._internal();

  int counts = 0;
  int totalCompletedPlaylist = 0;

  // Method to calculate total points
  Future<void> count() async {
    int tempCount = 0;
    for (var element in progressNotifier.value) {
      tempCount += element.totalPoint;
    }
    counts = tempCount;
  }

  // Method to calculate completed playlists
  Future<void> getCompletedPlaylist() async {
    totalCompletedPlaylist = await countTotalCompletedPlaylists();
  }
}
