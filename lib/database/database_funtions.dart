import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/course.dart';

ValueNotifier<List<Course>> courseNotifier = ValueNotifier([]);
ValueNotifier<List<SubCourse>> subCourseNotifier = ValueNotifier([]);
ValueNotifier<List<TutorialPlayList>> playlistNotifier = ValueNotifier([]);
ValueNotifier<List<QuestionNotes>> questionNoteNotifier = ValueNotifier([]);
ValueNotifier<List<Course>> enrolledCourseNotifier = ValueNotifier([]);
ValueNotifier<List<TutorialPlayList>> favoritePlaylistNotifier = ValueNotifier([]);

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
  final playlistId = await playlistBox.add(value);
  value.playlistId = playlistId;
  playlistBox.put(playlistId, value);
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

Future<void> updatePlaylist(
    int playlistId, String playlistTitle, String subCourseVideos) async {
  final playlistBox = await Hive.openBox<TutorialPlayList>('AddPlaylist');
  final updatePlaylistBox = playlistBox.get(playlistId);
  if (updatePlaylistBox == null) {
    print("Error: Course not found at index $playlistId");
    return;
  }
  final updatedPlayList = TutorialPlayList(
    playlistId: playlistId,
    subCourseId: updatePlaylistBox.subCourseId,
    playListTitle: playlistTitle,
    subCourseDetails: SubCourseDetails(subCourseVideo: subCourseVideos),
  );
  await playlistBox.put(playlistId, updatedPlayList);
  playlistNotifier.notifyListeners();
}

Future<void> fechingCourseDetails() async {
  final courseBox = await Hive.openBox<Course>('AddNewCourse');
  courseNotifier.value = courseBox.values.toList();
  courseNotifier.notifyListeners();
}

Future<void> fechingSubcourse() async {
  final subCourseBox = await Hive.openBox<SubCourse>('AddNewSubCourse');
  subCourseNotifier.value = subCourseBox.values.toList();
  courseNotifier.notifyListeners();
}

Future<void> fechingPlaylist() async {
  final playlistBox = await Hive.openBox<TutorialPlayList>('AddPlaylist');
  playlistNotifier.value = playlistBox.values.toList();
  playlistNotifier.notifyListeners();
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
    print("Error: Course not found at index $courseIndex");
    return;
  }
  final id = course.id;
  // if (id == null) {
  //   print("Error: Course ID is null");
  //   return;
  // }
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

Future<void> updateSubCourseTitle(
    int subIndex, String subImage, String subTitle) async {
  final updatedSubCourseBox = await Hive.openBox<SubCourse>('AddNewSubCourse');
  var updatedsubCourse = updatedSubCourseBox.getAt(subIndex);

  if (updatedsubCourse != null) {
    print(
        'Before Update: ${updatedsubCourse.subCourseTitle}, ${updatedsubCourse.subCourseThumbnailPath}');

    updatedsubCourse.subCourseTitle = subTitle;

    updatedsubCourse.subCourseThumbnailPath = subImage.isNotEmpty
        ? subImage
        : updatedsubCourse.subCourseThumbnailPath;

    await updatedSubCourseBox.put(subIndex, updatedsubCourse);

    print(
        'After Update: ${updatedsubCourse.subCourseTitle}, ${updatedsubCourse.subCourseThumbnailPath}');
    print(subIndex);
    // Optionally, update the notifier to refresh the UI
    subCourseNotifier.value = updatedSubCourseBox.values.toList();
    subCourseNotifier.notifyListeners();
  } else {
    print('No sub-course found at index $subIndex');
  }
}

Future<void> addEnrolledCourse(int courseId) async {
  final enrolledBox = await Hive.openBox<int>('EnrolledCourse');
   await enrolledBox.add(courseId);
  print('added added');

}
Future<void> getAllEnrolledCourse() async{
  final enrolledBox = await Hive.openBox<int>('EnrolledCourse');
  List<int> enrolledIdList = enrolledBox.values.toList();
  print(enrolledIdList);
  enrolledCourseNotifier.value = enrolledIdList.map((element) { 
   final  en = courseNotifier.value.firstWhere((course) => course.id==element,);
   return en;
  }
  ).toList();
  print('not added item in enrolled');
  enrolledCourseNotifier.notifyListeners();

}
Future<void> deleteEnrolledCourse(int id) async {
  final enrolledBox = await Hive.openBox<int>('EnrolledCourse');
  await enrolledBox.delete(id);
  playlistNotifier.notifyListeners();
  getAllEnrolledCourse();
}

Future<void> addFavorite(int playlistId)async{
  final favouriteBox = await Hive.openBox<int>('favorite');
 favouriteBox.add(playlistId);
}

Future<void> getAllFavoritePlaylist() async{
  final favouriteBox = await Hive.openBox<int>('favorite');
  List<int> favoriteList = favouriteBox.values.toList();
  favoritePlaylistNotifier.value = favoriteList.map((element) { 
   final  en = playlistNotifier.value.firstWhere((course) => course.playlistId==element,);
   return en;
  }
  ).toList();
  print('not added item in favouritePlaylist');
  favoritePlaylistNotifier.notifyListeners();

}

Future<void> deleteFavoriteCourse(int playlistId) async {
  final favouriteBox = await Hive.openBox<int>('favorite');
  await favouriteBox.delete(playlistId);
  favoritePlaylistNotifier.notifyListeners();
  getAllFavoritePlaylist();
}
