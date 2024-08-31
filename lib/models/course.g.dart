// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 0;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      id: fields[0] as int?,
      courseThumbnailPath: fields[1] as String,
      courseTitle: fields[2] as String,
      courseDetails: fields[3] as CourseDetails?,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.courseThumbnailPath)
      ..writeByte(2)
      ..write(obj.courseTitle)
      ..writeByte(3)
      ..write(obj.courseDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CourseDetailsAdapter extends TypeAdapter<CourseDetails> {
  @override
  final int typeId = 1;

  @override
  CourseDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseDetails(
      courseIntroductionVideo: fields[0] as String,
      courseDescription: fields[1] as String,
      subCourse: (fields[2] as List?)?.cast<SubCourse>(),
    );
  }

  @override
  void write(BinaryWriter writer, CourseDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.courseIntroductionVideo)
      ..writeByte(1)
      ..write(obj.courseDescription)
      ..writeByte(2)
      ..write(obj.subCourse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubCourseAdapter extends TypeAdapter<SubCourse> {
  @override
  final int typeId = 2;

  @override
  SubCourse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCourse(
      id: fields[3] as int?,
      courseId: fields[4] as int,
      subCourseThumbnailPath: fields[0] as String,
      subCourseTitle: fields[1] as String,
      tutorialPlayList: (fields[2] as List?)?.cast<TutorialPlayList>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubCourse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.subCourseThumbnailPath)
      ..writeByte(1)
      ..write(obj.subCourseTitle)
      ..writeByte(2)
      ..write(obj.tutorialPlayList)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.courseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TutorialPlayListAdapter extends TypeAdapter<TutorialPlayList> {
  @override
  final int typeId = 3;

  @override
  TutorialPlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TutorialPlayList(
      subCourseId: fields[2] as int,
      playListTitle: fields[0] as String,
      subCourseDetails: fields[1] as SubCourseDetails?,
      playlistId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TutorialPlayList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.playListTitle)
      ..writeByte(1)
      ..write(obj.subCourseDetails)
      ..writeByte(2)
      ..write(obj.subCourseId)
      ..writeByte(3)
      ..write(obj.playlistId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TutorialPlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubCourseDetailsAdapter extends TypeAdapter<SubCourseDetails> {
  @override
  final int typeId = 4;

  @override
  SubCourseDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCourseDetails(
      subCourseVideo: fields[0] as String,
      questionNotes: fields[1] as QuestionNotes?,
    );
  }

  @override
  void write(BinaryWriter writer, SubCourseDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.subCourseVideo)
      ..writeByte(1)
      ..write(obj.questionNotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCourseDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionNotesAdapter extends TypeAdapter<QuestionNotes> {
  @override
  final int typeId = 5;

  @override
  QuestionNotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionNotes(
      playlistId: fields[2] as int,
      noteId: fields[3] as int?,
      questions: (fields[0] as List).cast<String>(),
      answers: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionNotes obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.questions)
      ..writeByte(1)
      ..write(obj.answers)
      ..writeByte(2)
      ..write(obj.playlistId)
      ..writeByte(3)
      ..write(obj.noteId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionNotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
