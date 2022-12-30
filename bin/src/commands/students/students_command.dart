
import 'package:args/command_runner.dart';
import '../../repositories/dio/dio_student_repository.dart';
import '../../repositories/http/http_student_repository.dart';
import 'subcommands/delete_command.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id_command.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class StudentsCommand extends Command{
  @override
  String get description => "Students Operations";

  @override
  String get name => "students";


  StudentsCommand(){
    // final studentRepositoryHttp = HttpStudentRepository();
    final studentRepositoryDio = DioStudentRepository();
  
    //para poder rodar 'students/findall etc..
    addSubcommand(FindAllCommand(repository: studentRepositoryDio));
    addSubcommand(FindByIdCommand(repository: studentRepositoryDio));
    addSubcommand(InsertCommand(repository: studentRepositoryDio));
    addSubcommand(UpdateCommand(repository: studentRepositoryDio));
    addSubcommand(DeleteCommand(repository: studentRepositoryDio));
  }
  
}