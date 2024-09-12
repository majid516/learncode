import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/user_progress.dart';

ValueNotifier<List<UserProgress>> progressNotifier = ValueNotifier([]);

Future<void> addProgress(int courseId, int playlistCount) async {
  final progressBox = await Hive.openBox<UserProgress>('userProgress');
  final progress = UserProgress(courseId, 0, playlistCount);
  await progressBox.add(progress);
  log('Progress added: $progress');
}

Future<void> printAllProgress() async {
  final progressBox = await Hive.openBox<UserProgress>('userProgress');
  progressNotifier.value = progressBox.values.toList();
  progressNotifier.notifyListeners();
}

Future<void> updatePlaylistCount(int courseId, int newPlaylistsCount) async {
  final progressBox = await Hive.openBox<UserProgress>('userProgress');
  final index = progressBox.values
      .toList()
      .indexWhere((progress) => progress.courseId == courseId);
  if (index != -1) {
    final existingProgress = progressBox.getAt(index);
    final updatedProgress = UserProgress(
      courseId,
      existingProgress!.progressPoint,
      existingProgress.totalPoint + newPlaylistsCount,
    );
    await progressBox.putAt(index, updatedProgress);
    log('Playlist count updated for course $courseId: ${updatedProgress.totalPoint}');
    progressNotifier.value = progressBox.values.toList();
  } else {
    log('No progress found for course $courseId');
  }
  progressNotifier.notifyListeners();
}

Future<void> addPlaylistToProgress(int courseId, int playlistId) async {
  final progressBox = await Hive.openBox<UserProgress>('userProgress');
  final index = progressBox.values
      .toList()
      .indexWhere((progress) => progress.courseId == courseId);
  if (index != -1) {
    final existingProgress = progressBox.getAt(index);
    log('existingProgress == ${existingProgress!.progressPoint}');
    List<int> updatedCompletedPlaylists =
        List.from(existingProgress.completedPlaylist ?? []);
    if (!updatedCompletedPlaylists.contains(playlistId)) {
      updatedCompletedPlaylists.add(playlistId);
      final newProgressPoint = existingProgress.progressPoint + 1;
      final updatedProgress = UserProgress(
        courseId,
        newProgressPoint,
        existingProgress.totalPoint,
        updatedCompletedPlaylists,
      );
      await progressBox.putAt(index, updatedProgress);
      log('Playlist $playlistId added to completed playlists for course $courseId');
      progressNotifier.value = progressBox.values.toList();
      progressNotifier.notifyListeners();
    } else {
      log('Playlist $playlistId already completed for course $courseId');
    }
  } else {
    log('No progress found for course $courseId');
  }
}

Future<int> countTotalCompletedPlaylists() async {
  final progressBox = await Hive.openBox<UserProgress>('userProgress');
  int totalCompletedPlaylists = 0;

  for (var progress in progressBox.values) {
    totalCompletedPlaylists += progress.completedPlaylist?.length ?? 0;
  }

  log('Total completed playlists across all courses: $totalCompletedPlaylists');
  return totalCompletedPlaylists;
}
