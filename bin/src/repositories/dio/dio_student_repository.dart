import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../models/students.dart';

class DioStudentRepository {
  Future<List<Student>> findAll() async {
    //*HTTP
    // final studentsResult =
    //     await http.get(Uri.parse("http://localhost:8080/students"));
    //*HTTP
    // if (studentsResult.statusCode != 200) {
    //   throw Exception();
    // }

    //*HTTP
    // final studentsData = jsonDecode(studentsResult.body) as List;

    //*HTTP
    // return studentsData.map<Student>((student) {
    //   return Student.fromMap(student);
    // }).toList();

    try {
      //*DIO
      final studentsResult = await Dio().get("http://localhost:8080/students");

      //*DIO
      return studentsResult.data.map<Student>((student) {
        return Student.fromMap(student);
      }).toList();
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Student> findById(int id) async {
    //*HTTP
    // final studentsResult =
    //     await http.get(Uri.parse("http://localhost:8080/students/$id"));

    //*HTTP
    // if (studentsResult.statusCode != 200) {
    //   throw Exception();
    // }

    //*HTTP
    // if (studentsResult.body == "{}") {
    //   throw Exception();
    // }

    //*HTTP
    // return Student.fromJson(studentsResult.body);

    try {
      //*DIO
      final studentResponse =
          await Dio().get("http://localhost:8080/students/$id");

      //*DIO
      if (studentResponse.data == null) {
        throw Exception();
      }

      //*DIO (precisamos chamar o fromMap pois o dio ja faz o fromJson)
      return Student.fromMap(studentResponse.data);
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Student student) async {
    //*HTTP
    // final response = await http.post(
    //     Uri.parse("http://localhost:8080/students"),
    //     body: student.toJson(),
    //     headers: {"content-type": "application/json"});

    // if (response.statusCode != 200) {
    //   throw Exception();
    // }

    //*DIO
    try {
      await Dio().post(
        "http://localhost:8080/students",
        data: student.toMap(),
      );
    } on Exception catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Student student) async {
    //*HTTP
    // final response = await http.put(
    //     Uri.parse("http://localhost:8080/students/${student.id}"),
    //     body: student.toJson(),
    //     headers: {"content-type": "application/json"});

    // if (response.statusCode != 200) {
    //   throw Exception();
    // }

    //*DIO
    try {
      await Dio().put(
        "http://localhost:8080/students/${student.id}",
        data: student.toMap(),
      );
    } on Exception catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    //*HTTP
    // final response =
    //     await http.delete(Uri.parse("http://localhost:8080/students/$id"));

    // if (response.statusCode != 200) {
    //   throw Exception();
    // }

    //*DIO
    try {
      await Dio().delete("http://localhost:8080/students/$id");
    } on Exception catch (e) {
      print(e);
      throw Exception();
    }
  }
}
