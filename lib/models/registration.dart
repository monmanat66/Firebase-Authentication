
class Registration {
  final int? id;
  final String studentId;
  final String firstName;
  final String lastName;
  final String program;
  final String activityName;
  final String createdAt;
  final String userUid;

  Registration({
    required this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.program,
    required this.activityName,
    required this.createdAt,
    required this.userUid,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'student_id': studentId,
    'first_name': firstName,
    'last_name': lastName,
    'program': program,
    'activity_name': activityName,
    'created_at': createdAt,
    'user_uid': userUid,
  };

  factory Registration.fromMap(Map<String, Object?> map) => Registration(
    id: map['id'] as int?,
    studentId: map['student_id'] as String,
    firstName: map['first_name'] as String,
    lastName: map['last_name'] as String,
    program: map['program'] as String,
    activityName: map['activity_name'] as String,
    createdAt: map['created_at'] as String,
    userUid: map['user_uid'] as String,
  );
}
