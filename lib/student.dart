
class Student {
  final int id;
  final String name;
  final String course;

  Student({
    required this.id,
    required this.name,
    required this.course,
  });

  // Convert Student object into JSON-compatible data.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
    };
  }

  // Convert JSON data back into a Student object.
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      course: json['course'] as String,
    );
  }
}
