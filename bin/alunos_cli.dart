import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'src/commands/students/students_command.dart';

void main(List<String> arguments) {
    CommandRunner("Students CLI", "API CLI LAB")
    ..addCommand(StudentsCommand())
    ..run(arguments);


}

