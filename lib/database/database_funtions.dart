import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/models/user_details.dart';

ValueNotifier<List<Course>> courseNotifier = ValueNotifier([]);
ValueNotifier<List<Course>> subCourseNotifier = ValueNotifier([]);

Future<void> addNewCourse(Course values) async {
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  int id = await courseBox.add(values);
  values.id = id;

  courseNotifier.value = courseBox.values.toList();
  courseNotifier.notifyListeners();
}


Future<void> fechingCourseDetails()async{
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  courseNotifier.value = courseBox.values.toList();
  courseNotifier.notifyListeners();

}





Future<void> addNewSubCouse(Course values) async {
  final newSubCourse = await Hive.openBox<Course>('AddNewCourse');
  newSubCourse.add(values);
}

Future<Box<UserDetails>> openDbUserDetails() async {
  return await Hive.openBox<UserDetails>('user_details');
}

Future<void> addUserDetails(UserDetails values) async {
  final userDatas = await openDbUserDetails();
  userDatas.add(values);
}

Future<UserDetails?> fechingUserDetails() async {
  final userDatas = await openDbUserDetails();
  userDatas.get('user');
}
