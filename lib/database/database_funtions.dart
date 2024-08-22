import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/course.dart';

ValueNotifier<List<Course>> courseNotifier = ValueNotifier([]);
ValueNotifier<List<SubCourse>> subCourseNotifier = ValueNotifier([]);
ValueNotifier<List<TutorialPlayList>> playlistNotifier = ValueNotifier([]);
ValueNotifier<List<QuestionNotes>> questionNoteNotifier = ValueNotifier([]);

Future<void> addNewCourse(Course values) async {
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  int id = await courseBox.add(values);
  values.id = id;
  await courseBox.put(id, values);
  courseNotifier.value = courseBox.values.toList();
  courseNotifier.notifyListeners();
  print(id);
  print('valuessss${values.id}');
}

Future<void> addNewSubCourse(SubCourse value) async {
  final subCourseBox = await Hive.openBox<SubCourse>('AddNewSubCourse');
  int id = await subCourseBox.add(value);
  value.id = id;
  subCourseNotifier.value = subCourseBox.values.toList();
  subCourseNotifier.notifyListeners();
}

void fechingCourseDetails() async {
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  courseNotifier.value = courseBox.values.toList();
  courseNotifier.notifyListeners();
}

Future<void> deleteCourse(int id) async {
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  await courseBox.delete(id);
  courseNotifier.notifyListeners();
  fechingCourseDetails();
}

Future<void> addPlayList(TutorialPlayList value) async {
  final playlistBox = await Hive.openBox<TutorialPlayList>('AddPlaylist');
  await playlistBox.add(value);
  playlistNotifier.value = playlistBox.values.toList();
  playlistNotifier.notifyListeners();
}

void fechingPlaylist() async {
  final playlistBox = await Hive.openBox<TutorialPlayList>('AddPlaylist');
  playlistNotifier.value = playlistBox.values.toList();
  playlistNotifier.notifyListeners();
}

Future<void> addNotes(QuestionNotes value) async {
  final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
  await noteBox.add(value);
  questionNoteNotifier.value = noteBox.values.toList();
  questionNoteNotifier.notifyListeners();
}

Future<void> updateCouse(
  int courseIndex,
  String courseName,
  String courseDiscription,
  String thumbnail,
  String video,
) async {
  final courseBoxs = await Hive.openBox<Course>('AddNewCourse');
  final course = courseBoxs.getAt(courseIndex);
  
  if (course == null) {
    // Handle the case when the course is null
    print("Error: Course not found at index $courseIndex");
    return; // Exit the function early
  }

  final id = course.id;

  if (id == null) {
    // Handle the case when id is null
    print("Error: Course ID is null");
    return;
  }

  final updatedCourse = Course(
    id: id,
    courseThumbnailPath: thumbnail,
    courseTitle: courseName,
    courseDetails: CourseDetails(
      courseIntroductionVideo: video,
      courseDescription: courseDiscription,
    ),
  );
 print('id = ${id}');
 print(updatedCourse);
  await courseBoxs.put(id, updatedCourse); 
}

Future<void> updateSubCourseTitle(int subIndex, String subImage, String subTitle) async {
  final updatedSubCourseBox = await Hive.openBox<SubCourse>('AddNewSubCourse');
  var updatedsubCourse = updatedSubCourseBox.getAt(subIndex);

  if (updatedsubCourse != null) {
    print('Before Update: ${updatedsubCourse.subCourseTitle}, ${updatedsubCourse.subCourseThumbnailPath}');
    
    updatedsubCourse.subCourseTitle = subTitle;
    
    updatedsubCourse.subCourseThumbnailPath = subImage.isNotEmpty ? subImage : updatedsubCourse.subCourseThumbnailPath;

    await updatedSubCourseBox.put(subIndex, updatedsubCourse);

    print('After Update: ${updatedsubCourse.subCourseTitle}, ${updatedsubCourse.subCourseThumbnailPath}');
    print(subIndex);
    // Optionally, update the notifier to refresh the UI
    subCourseNotifier.value = updatedSubCourseBox.values.toList();
    subCourseNotifier.notifyListeners();
  } else {
    print('No sub-course found at index $subIndex');
  }
}
