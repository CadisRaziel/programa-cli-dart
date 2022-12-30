import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/students.dart';
import '../../../repositories/dio/dio_product_repository.dart';
import '../../../repositories/dio/dio_student_repository.dart';
import '../../../repositories/http/http_product_repository.dart';
import '../../../repositories/http/http_student_repository.dart';


class InsertCommand extends Command {
  // final HttpStudentRepository repository;
  // final productRepository =
  //     HttpProductRepository(); //quando instanciamos assim, estamos inicializando a classe
  final DioStudentRepository repository;
  final productRepository = DioProductRepository();
  

  InsertCommand({
    required this.repository,
  }) {
    argParser.addOption("file", help: "Path of the csv file", abbr: "f");
  }

  @override
  String get description => "Insert Student";

  @override
  String get name => "insert";

  @override
  Future<void> run() async {
    print("Aguarde...");
    final filePath = argResults?["file"];
    final students = File(filePath).readAsLinesSync();
    print('------------------------------');
    for (var student in students) {
      final studentData = student.split(';');
      final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

      //buscando curso
      //map para pegar a lista de string e transformar em uma lista de objeto Courses(modelo)
      final coursesFutures = courseCsv.map((c) async {
        final course = await productRepository.findByname(c);
        course.isStudent = true;
        return course;
      }).toList();

      //!para evitar o 'instance of future' poderiamos fazer isso
      // final courses = await Future.forEach(courseCsv, (c) async {
      //   final course = await productRepository.findByname(c);
      //   course.isStudent = true;
      //   return course;
      // });

      //quando temos um await dentro do map se nao fizermos ele espera com o future.wait, no debug teremos 'instance of 'Future<course>'
      //Future.wait vai fazer o map async aguardar ele fazer todo o loop
      final courses = await Future.wait(coursesFutures);

      final studentModel = Student(
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: City(id: 1, name: studentData[6]),
          phone: Phone(
            ddd: int.parse(studentData[7]),
            phone: studentData[8],
          ),
        ),
      );
      await repository.insert(studentModel);
     
    }
     print('------------------------------');
      print("Alunos adicionados com sucesso");
  }
}
