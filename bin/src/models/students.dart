import 'dart:convert';

import 'address.dart';
import 'courses.dart';

class Student {
  //para fazer 'insert' o ID preicsa ser nullo
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Course> courses;
  final Address address;

  Student({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "id": id,
      "name": name,
      "nameCourses": nameCourses,
      "courses": courses.map((course) => course.toMap()).toList(),
      "address": address.toMap(),
    };


    //Como eu tenho um campo que pode ser nullo(veja na api os objetos tem um que nao tem 'age' então ele pode ser nullo)
    if (age != null){
      map["age"] = age;
    }

    return map;
  }

  String toJson() => jsonEncode(toMap());

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        id: map["id"] ?? 0,
        name: map["name"] ?? "",
        age: map["age"], //! Como eu ja to verificando no toMap se é nullo ou não, aqui eu nao preciso verificar !!
        nameCourses: List<String>.from(map["nameCourses"] ?? <String>[]),
        courses: map["courses"]
                ?.map<Course>((coursesMap) => Course.fromMap(coursesMap))
                .toList() ??
            <Course>[],
        address: Address.fromMap(map["address"] ?? <String, dynamic>{}));
  }

  factory Student.fromJson(String json) => Student.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'Students(id: $id, name: $name, age: $age, nameCourses: $nameCourses, courses: $courses, address: $address)';
  }
}
