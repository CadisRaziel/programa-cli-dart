
import 'dart:convert';

class Course {
  final int id;
  final String name;
  bool isStudent;

  Course({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "isStudent": isStudent,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map["id"] ?? 0,
      name: map["name"] ?? "",
      isStudent: map["isStudent"] ?? false,
    );
  }
  factory Course.fromJson(String json) => Course.fromMap(jsonDecode(json));

  @override
  String toString() => 'Courses(id: $id, name: $name, isStudent: $isStudent)';
}
