
import 'package:hive_flutter/hive_flutter.dart';
part 'course.g.dart';


@HiveType(typeId: 0)
class Course {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String
      courseThumbnailPath; // Change from ImageProvider<Object> to String
  @HiveField(2)
  final String courseTitle;
  @HiveField(3)
  final CourseDetails? courseDetails;

  Course({
    this.id,
    required this.courseThumbnailPath,
    required this.courseTitle,
    this.courseDetails,
  });
}

@HiveType(typeId: 1)
class CourseDetails {
  @HiveField(0)
  final String courseIntroductionVideo;

  @HiveField(1)
  final String courseDescription;

  @HiveField(2)
  final List<SubCourse>? subCourse;

  CourseDetails({
    required this.courseIntroductionVideo,
    required this.courseDescription,
    this.subCourse,
  });
}

@HiveType(typeId: 2)
class SubCourse {
  @HiveField(0)
  final String subCourseThumbnailPath;
  @HiveField(1)
  final String subCourseTitle;
  @HiveField(2)
  final List<TutorialPlayList>? tutorialPlayList;

  SubCourse({
    required this.subCourseThumbnailPath,
    required this.subCourseTitle,
    this.tutorialPlayList,
  });
}

@HiveType(typeId: 3)
class TutorialPlayList {
  @HiveField(0)
  final String playListTitle;
  @HiveField(1)
  final SubCourseDetails? subCourseDetails;

  TutorialPlayList({
    required this.playListTitle,
    this.subCourseDetails,
  });
}

@HiveType(typeId: 4)
class SubCourseDetails {
  @HiveField(0)
  final String subCourseVideo;
  @HiveField(1)
  final QuestionNotes? questionNotes;

  SubCourseDetails({
    required this.subCourseVideo,
    this.questionNotes,
  });
}

@HiveType(typeId: 5)
class QuestionNotes {
  @HiveField(0)
  final List<String> questions;

  @HiveField(1)
  final List<String> answers;

  QuestionNotes({
    required this.questions,
    required this.answers,
  });
}


