import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/students.dart';


class HttpStudentRepository {
  Future<List<Student>> findAll() async {
    final studentsResult =
        await http.get(Uri.parse("http://localhost:8080/students"));

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }

    //lembrando colocamos o 'as list' pois a api esta dizendo que é uma list
    final studentsData = jsonDecode(studentsResult.body) as List;

    //Não esqueca de tipar o map <Student> se não da erro na conversão
    return studentsData.map<Student>((student) {
      return Student.fromMap(student);
    }).toList();

    //!Obs importante, o autoComplete as vezes nao funciona, porque ? Porque se voce por o mouse em cima de 'studentsData' ele ta retornando um dynamic
    //!e o dynamic nao da o autoComplete (pois ele não sabe o que é a classe de verdade)
    //!para arrumar isso podemos por um alias ali no 'studentsData' como 'list', olhe la como eu coloquei (é uma lista pois retorna uma lista de objetos)
  }

  Future<Student> findById(int id) async {
    final studentsResult =
        await http.get(Uri.parse("http://localhost:8080/students/$id"));

    if(studentsResult.statusCode != 200) {
      throw Exception();
    }

    //não precisaria fazer essa verificação, mais fiz pra deixar completa
    //caso eu pesquisar o id e não existir a api retorna um objeto vazio
    if (studentsResult.body == "{}") {
      throw Exception();
    }

    //!Repare como não é um array eu nao preciso fazer o JsonDecode e o fromMap !!
    return Student.fromJson(studentsResult.body);
  }

  //insert -> inserindo um novo estudante(cadastrar novo aluno)
  Future<void> insert(Student student) async {
    final response = await http.post(
      Uri.parse("http://localhost:8080/students"),
      //enviando um novo usuario para o backend
      //no http eu preciso informar o header, ja no dio eu nao preciso, pois la ele ja deixa tudo certo por default
      body: student.toJson(),
      headers: {
        "content-type": "application/json"
      }
    );

    if(response.statusCode != 200){
      throw Exception();
    } 
  }

  //update -> atualizar os dados de um student
  Future<void> update(Student student) async {
       final response = await http.put(
      Uri.parse("http://localhost:8080/students/${student.id}"),
      //enviando um novo usuario para o backend
      //no http eu preciso informar o header, ja no dio eu nao preciso, pois la ele ja deixa tudo certo por default
      body: student.toJson(),
      headers: {
        "content-type": "application/json"
      }
    );

    if(response.statusCode != 200){
      throw Exception();
    } 
  }

  Future<void> deleteById(int id) async {
    final response = await http.delete(Uri.parse("http://localhost:8080/students/$id"));

    if(response.statusCode != 200) {
      throw Exception();
    }
  }
}
