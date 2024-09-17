import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/models/course.dart';

class UserProgressPage extends StatefulWidget {
  const UserProgressPage({super.key});

  @override
  State<UserProgressPage> createState() => _UserProgressPageState();
}

ValueNotifier<List<Course>> userProgressNotifier = ValueNotifier([]);

class _UserProgressPageState extends State<UserProgressPage> {
  @override
  void initState() {
    fechPlaylist();
    printAllProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                        iconColor: themeTextColor,
                        buttonColor: buttonGrey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const Text(
                      'your progress',
                      style: tutorialPageTitletextStyle,
                    ),
                    const SizedBox(
                      width: 60,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: progressNotifier,
                  builder: (context, progressValue, child) {
                    if (progressValue.isEmpty ||
                        userProgressNotifier.value.isEmpty) {
                      return const Center(
                        child: Text('No Progress Available'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: progressNotifier.value.length,
                      itemBuilder: (ctx, index) {
                        final progressData = progressValue[index];
                        final course = userProgressNotifier.value[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: InkWell(
                            child: Container(
                              width:kIsWeb?ScreenSize.widthMed*0.8: ScreenSize.widthMed,
                              height:kIsWeb?ScreenSize.widthMed*0.1: ScreenSize.widthMed * 0.3,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: kIsWeb
                                                    ? ScreenSize.widthMed * 0.13
                                                    : ScreenSize.widthMed *
                                                        0.27,
                                                height: kIsWeb
                                                    ? ScreenSize.widthMed * 0.08
                                                    : ScreenSize.widthMed * 0.2,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: kIsWeb
                                                        ? MemoryImage(
                                                            base64Decode(course
                                                                .courseThumbnailPath))
                                                        : FileImage(
                                                            File(course
                                                                .courseThumbnailPath),
                                                          ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    course.courseTitle,
                                                    style: accountPagetextStyle,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(

                                                      height: 10,
                                                      width:kIsWeb?ScreenSize.widthMed*0.75:
                                                          ScreenSize.widthMed *
                                                              0.42,
                                                      child:
                                                          LinearProgressIndicator(
                                                        value: progressData
                                                                .progressPoint /
                                                            progressData
                                                                .totalPoint,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                        color: themeTextColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${progressData.progressPoint} / ${progressData.totalPoint}',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

void fechPlaylist() {
  for (var progress in progressNotifier.value) {
    var value = courseNotifier.value
        .firstWhere((value) => value.id == progress.courseId);
    userProgressNotifier.value.add(value);
  }
  userProgressNotifier.notifyListeners();
  progressNotifier.notifyListeners();
}
