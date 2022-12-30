
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/dio/dio_student_repository.dart';
import '../../../repositories/http/http_student_repository.dart';

class DeleteCommand extends Command {
  final DioStudentRepository repository;
  // final HttpStudentRepository repository;
  DeleteCommand({
    required this.repository,
  }) {
    argParser.addOption("id", help: "Delete Student by id", abbr: "i");
  }

  @override 
  String get description => "Delete Student by id";

  @override 
  String get name => "delete";

  @override
  Future<void> run() async {

    //caso o usuario nao passe nenhum id, aqui fazemos uma verificação
     if(argResults?["id"] == null){
      print("Por favor envie o ID do aluno com o comando --id=0 ou -i 0");
      return;
    }

    //depois de verificado se é nulo ou não aqui o parse nao vai deixar nada nulo passar
    final id = int.parse(argResults?["id"]);
    print('Aguarde buscando dados...');

    //aqui eu vou procurar o aluno pelo id para apresentar uma msg se o usuario quer deletar esse aluno msm
    final student = await repository.findById(id);
    print('------------------------------');
    print("Tem certeza que deseja deletar o aluno ${student.name}? S/N");
    final decision = stdin.readLineSync();

    //aqui eu pego a entrada do usaurio tramsfomo em lowercase pra nao da confução e se ele dizer "s" eu deleto o usuario pelo id
    //e mando uma msg deletado com sucesso
    if(decision?.toLowerCase() == "s") {
      await repository.deleteById(id);
      print("Aluno deletado com sucesso");
    } else {
      print("Operação cancelada");
    }
    
  }
  
}
