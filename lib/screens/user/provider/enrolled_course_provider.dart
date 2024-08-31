import 'package:flutter/material.dart';
import 'package:learncode/models/course.dart';
import 'package:provider/provider.dart';

class EnrolledCourseProvider extends ChangeNotifier{
 final List<Course> _myEnrolledCourseList = [];
 List<Course> get myEnrolledCourseList => _myEnrolledCourseList;

 void toggleEnrolledCourse(Course course){
  if (_myEnrolledCourseList.contains(course)) {
    _myEnrolledCourseList.remove(course);
  }else{
    _myEnrolledCourseList.add(course);
  }
  notifyListeners();
 }

 bool isExist(Course course){
  final isExist = _myEnrolledCourseList.contains(course);
  return isExist;
 }

 static EnrolledCourseProvider of(context , {bool listen = true}){
   return Provider.of<EnrolledCourseProvider>(context, listen: listen);
 }
}