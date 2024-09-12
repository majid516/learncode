import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';

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
  await subCourseBox.put(id, value);
  subCourseNotifier.value = subCourseBox.values.toList();
  subCourseNotifier.notifyListeners();
  print('courseInsex = ${value.courseId}');
  print('subcourseInsex = ${value.id}');
}

Future<void> addPlayList(TutorialPlayList value) async {
  final playlistBox = await Hive.openBox<TutorialPlayList>('AddPlaylist');
  final subCourseBox = await Hive.openBox<SubCourse>('AddNewSubCourse');

  final playlistId = await playlistBox.add(value);
  value.playlistId = playlistId;
  await playlistBox.put(playlistId, value);

  SubCourse? subCourse = subCourseBox.get(value.subCourseId);
  if (subCourse != null) {
    subCourse.tutorialPlayList = (subCourse.tutorialPlayList ?? [])..add(value);
    await subCourseBox.put(subCourse.id, subCourse);
  }

  playlistNotifier.value = playlistBox.values.toList();
  playlistNotifier.notifyListeners();
}

Future<void> addNotes(QuestionNotes value) async {
  final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
  final noteId = await noteBox.add(value);
  value.noteId = noteId;
  noteBox.put(noteId, value);
  questionNoteNotifier.value = noteBox.values.toList();
  questionNoteNotifier.notifyListeners();
}

Future<void> addEnrolledCourse(int courseId) async {
  final enrolledBox = await Hive.openBox<int>('EnrolledCourse');
  await enrolledBox.add(courseId);
  print('added added');
}

Future<void> getAllEnrolledCourse() async {
  final enrolledBox = await Hive.openBox<int>('EnrolledCourse');

  List<int> enrolledIdList = enrolledBox.values.toList();
  enrolledCourseNotifier.value = enrolledIdList.map((element) {
    final en = courseNotifier.value.firstWhere(
      (course) => course.id == element,
    );
    return en;
  }).toList();
  enrolledCourseNotifier.notifyListeners();
}
