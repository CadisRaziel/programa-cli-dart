import 'package:args/command_runner.dart';

import '../../../repositories/dio/dio_student_repository.dart';
import '../../../repositories/http/http_student_repository.dart';


class FindByIdCommand extends Command {
  // final HttpStudentRepository repository;
  final DioStudentRepository repository;
  
  FindByIdCommand({
    required this.repository,
  }) {
    //adicionando comandos para o parse optiona
    argParser.addOption("id", help: "Student id", abbr: "i");
  }
  @override
  String get description => "Find student by id";

  @override
  String get name => "byId";
  
  get repo => null;

  @override
  Future<void> run() async {    
    if(argResults?["id"] == null){
      print("Por favor envie o ID do aluno com o comando --id=0 ou -i 0");
      return;
    }
    //tryParse => pode ser que retorna nulo
    //Parse => nao deixa ser nulo
    final id = int.parse(argResults?["id"]);
     print('Aguarde buscando dados...');
     final student = await repository.findById(id);
     print('------------------------------');
     print("Aluno: ${student.name}");
     print('------------------------------');   
     print("Idade: ${student.age ?? "Não informado"}");   
    //  student.nameCourses.forEach((e) => print("Cursos $e"));
      for (var e in student.nameCourses) {
        print("Cursos: $e");
      }
     print("Endereço: ");
     print("${student.address.street} - ${student.address.zipCode}");
     
  }
}
