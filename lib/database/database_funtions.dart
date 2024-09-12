import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/course.dart';

ValueNotifier<List<Course>> courseNotifier = ValueNotifier([]);
ValueNotifier<List<SubCourse>> subCourseNotifier = ValueNotifier([]);
ValueNotifier<List<TutorialPlayList>> playlistNotifier = ValueNotifier([]);
ValueNotifier<List<QuestionNotes>> questionNoteNotifier = ValueNotifier([]);
ValueNotifier<List<Course>> enrolledCourseNotifier = ValueNotifier([]);
ValueNotifier<List<TutorialPlayList>> favoritePlaylistNotifier =
    ValueNotifier([]);

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
    subCourseNotifier.value = updatedSubCourseBox.values.toList();
    subCourseNotifier.notifyListeners();
  } else {
    print('No sub-course found at index $subIndex');
  }
}

Future<void> addFavoritePlaylist(int playlistId) async {
  final favoriteBox = await Hive.openBox<int>('Favorites');
  await favoriteBox.add(playlistId);
  favoritePlaylistNotifier.notifyListeners();
  
}


Future<void> getAllFavorites() async {
  final favoriteBox = await Hive.openBox<int>('Favorites');
  List<int> favoriteList = favoriteBox.values.toList();

  print('Favorite List: $favoriteList');

  // Ensure playlistNotifier is not null and has data
  if (playlistNotifier.value.isEmpty) {
    print('No playlists available in playlistNotifier');
    return;
  }

  // Create a set of existing playlist IDs for fast lookup
  final existingPlaylistIds = playlistNotifier.value.map((course) => course.playlistId).toSet();
  print('Existing Playlist IDs: $existingPlaylistIds');

  // Filter and map favoriteList to only include valid entries
  List<TutorialPlayList> updatedFavorites = favoriteList
      .where((id) => existingPlaylistIds.contains(id)) // Filter out IDs that don't exist
      .map((id) => playlistNotifier.value.firstWhere(
            (course) => course.playlistId == id,
          ))
      .toList();

  print('Updated Favorites: $updatedFavorites');

  favoritePlaylistNotifier.value = updatedFavorites;
  favoritePlaylistNotifier.notifyListeners();
}


// Future<void> getAllFavorites() async {
//   final favoriteBox = await Hive.openBox<int>('Favorites');
//   List<int> favoriteList = favoriteBox.values.toList();
//   favoritePlaylistNotifier.value = favoriteList.map((element) {
//     final en = playlistNotifier.value.firstWhere(
//       (course) => course.playlistId == element,
//     );
//     return en;
//   }).toList();
//   print('not added item in favouritePlaylist');
//   favoritePlaylistNotifier.notifyListeners();
// }