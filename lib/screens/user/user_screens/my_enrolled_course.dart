import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';

class MyEnrolledCourses extends StatefulWidget {
  const MyEnrolledCourses({super.key});

  @override
  State<MyEnrolledCourses> createState() => _MyEnrolledCoursesState();
}

class _MyEnrolledCoursesState extends State<MyEnrolledCourses> {
  @override
  void initState() {
    getAllEnrolledCourse();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
   //  getAllEnrolledCourse();
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
                    'My Enrolled Course',
                    style: tutorialPageTitletextStyle,
                  ),
                 const SizedBox(width: 30,)
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: enrolledCourseNotifier,
                builder: (context, courses, child) {
                return  enrolledCourseNotifier.value.isEmpty ?
                const  Center(child: Text('Enrolled Course Not Availabe')):
                   ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: courses.length,
                    itemBuilder: (ctx, index) {
                      final courseData = courses[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: InkWell(
                          child: Container(
                            width: ScreenSize.widthMed,
                            height: ScreenSize.widthMed * 0.3,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: ScreenSize.widthMed * 0.3,
                                          height: ScreenSize.widthMed * 0.2,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.black.withOpacity(0.5)
                                              )
                                            ],
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    File(
                                                      courseData.courseThumbnailPath,
                                                    ),
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                      const  SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          courseData.courseTitle,
                                          style: accountPagetextStyle,
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Column(
                                    children: [
                                      Container(
                                        width: ScreenSize.widthMed * 0.2,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            gradient: themePurple,
                                            borderRadius: BorderRadius.circular(10)),
                                        child:const Center(
                                            child: Text(
                                          'enrolled',
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(context: context, builder: (ctx){return AlertDialog(
                                              content:const Text('are you sure to remove this course',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                }, child:const Text('cancel',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),

                                                
                                                 TextButton(onPressed: (){
                                                  deleteEnrolledCourse(courseData.id!);
                                                  Navigator.of(context).pop();

                                                }, child:const Text('remove',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                                              ],
                                            );});

                                          },
                                          icon:const Icon(
                                            Icons.delete,
                                            color:
                                                 Color.fromARGB(255, 205, 28, 15),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
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
                                  description:
                                      courseData.courseDetails?.courseDescription ??
                                          'Description',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
