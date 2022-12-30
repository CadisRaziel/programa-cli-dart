import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../models/courses.dart';

class HttpProductRepository {
  //? Repositório para nós fazer o insert (para podermos traze o nome do curso)
  Future<Course> findByname(String name) async {
    final response =
        await http.get(Uri.parse("http://localhost:8080/products?name=$name"));

    if (response.statusCode != 200) {
      throw Exception();
    }

    //se ele nao for diferente de 200 eu vou retornar o curso
    //repare que na api ela retorna isso abaixo (um array)
    //se nao fosse um array eu nao precisaria fazer o jsonDecode
    /*
    [
      {
        "id": 0,
        "name": "Academia do flutter"
      }
    ]
  */
    //!então como ele vai retornar um array (mais que um objeto) preciso fazer um parse dele
    //! porque ? porque vou pegar o 1 item da lista(se ele nao for vazia) e retornar ela para fazer o request
    //! então preciso decodificar o meu json - deserializar ele para um map de chave valor para ver se é vazio etc..
    final responseData = jsonDecode(response.body);

    //se for vazio quer dizer que não existe nada
    if (responseData.isEmpty) {
      throw Exception("Produto não encontrado");
    }
    //ou -> responseData[0], ja esse nao retorna erro
    //o first retorna erro caso não encontra nada
    return Course.fromMap(responseData.first);
  }
}
