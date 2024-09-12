import 'package:hive_flutter/hive_flutter.dart';
part 'user_progress.g.dart';

@HiveType(typeId: 9)
class UserProgress {
  @HiveField(0)
  final int courseId;
  @HiveField(1)
  final int progressPoint; 
  @HiveField(2)
  final int totalPoint; 
  @HiveField(3)
  final List<int>? completedPlaylist;
  UserProgress(
    this.courseId,
    this.progressPoint,
    this.totalPoint,
    [this.completedPlaylist, ]
  );
}
