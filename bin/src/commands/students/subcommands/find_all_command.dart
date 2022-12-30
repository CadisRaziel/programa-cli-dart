import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/dio/dio_student_repository.dart';
import '../../../repositories/http/http_student_repository.dart';



class FindAllCommand extends Command {
  // final HttpStudentRepository repository;
  final DioStudentRepository repository;

  FindAllCommand({
    required this.repository,
  });

  @override
  String get description => "Find all Students";

  @override
  String get name => "findAll";

  @override
  Future<void> run() async {
    print('Aguarde buscando alunos...');
    final students = await repository.findAll();      
    print("Apresentar tambem os cursos ? S/N");
    final showCourses = stdin.readLineSync();
    print('------------------------------');
    print("Alunos");
    print('------------------------------');
    //!se eu nao fizer um loop eu vou usar o .first e isso só pega um valor (porém é uma lista tem varios valores)
    // print("${students.first.nameCourses}");

    //!Para eu pegar todos os valores eu preciso fazer um loop
    for (var student in students) {
      if (showCourses?.toLowerCase() == "s") {
        print(
            "${student.id} - ${student.name} - ${student.courses.where((course) => course.isStudent).map((e) => e.name).toList()}");
      } else {
        print("${student.id} - ${student.name}");
      }
    }
  }
}
