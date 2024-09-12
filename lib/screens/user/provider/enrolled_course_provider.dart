import 'package:flutter/material.dart';
import 'package:learncode/database/course_add_functions.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:provider/provider.dart';

class EnrolledCourseProvider extends ChangeNotifier{
 final List<Course> _myEnrolledCourseList = [];
 List<Course> get myEnrolledCourseList => _myEnrolledCourseList;

 void toggleEnrolledCourse(Course course)async{
  if (_myEnrolledCourseList.contains(course)) {
    _myEnrolledCourseList.remove(course);
  }else{
    _myEnrolledCourseList.add(course);
  }
  await getAllEnrolledCourse();
  notifyListeners();
 }

 bool isExist(Course course){
  final isExist = enrolledCourseNotifier.value.contains(course)||_myEnrolledCourseList.contains(course);
  return isExist;
 }

 static EnrolledCourseProvider of(context , {bool listen = true}){
   return Provider.of<EnrolledCourseProvider>(context, listen: listen);
 }
}