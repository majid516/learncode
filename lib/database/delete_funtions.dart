import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/database/course_add_functions.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';

Future<void> deleteNotes(int id) async {
  final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
  await noteBox.delete(id);
  questionNoteNotifier.notifyListeners();
}

Future<void> deleteCourse(int id) async {
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  await courseBox.delete(id);
  courseNotifier.notifyListeners();
  fechingCourseDetails();
}

Future<void> deleteSubCourse(int id) async {
  final subCourseBox = await Hive.openBox<SubCourse>('AddNewSubCourse');
  await subCourseBox.delete(id);
  subCourseNotifier.notifyListeners();
  fechingSubcourse();
}

Future<void> deletePlaylist(int id) async {
  final playlistBox = await Hive.openBox<TutorialPlayList>('AddPlaylist');
  await playlistBox.delete(id);
  playlistNotifier.notifyListeners();
  fechingPlaylist();
}

Future<void> deleteEnrolledCourse(int id) async {
  final enrolledBox = await Hive.openBox<int>('EnrolledCourse');
  await enrolledBox.delete(id);
  playlistNotifier.notifyListeners();
  getAllEnrolledCourse();
}

Future<void> deleteFavoriteCourse(int playlistId) async {
  final favoriteBox = await Hive.openBox<int>('Favorites');
  List<int> list = favoriteBox.values.toList();

  print('delete funtion worked   ${playlistId}');
  favoritePlaylistNotifier.notifyListeners();

  int ind = 0;
  for (var i = 0; i < list.length; i++) {
    if (list[i] == playlistId) {
      ind = i;
      break;
    }
  }
  await favoriteBox.deleteAt(ind);
}
