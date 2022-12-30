import 'dart:convert';

import 'package:dio/dio.dart';
import '../../models/courses.dart';

class DioProductRepository {
  Future<Course> findByname(String name) async {
    //*HTTP
    //   final response =
    //       await http.get(Uri.parse("http://localhost:8080/products?name=$name"));

    //*DIO(nao precisamos fazer o Uri.parse)
    //*na url removemos o query parameter de la, pois o dio ja tem um queryParameters proprio ele mesmo ja coloca "?="
    final response =
        await Dio().get("http://localhost:8080/products", 
      queryParameters: {
      "name": name,
    });

    //*HTTP
    // if (response.statusCode != 200) {
    //   throw Exception();
    // }

    //*DIO (nao precisamos fazer vericiação de statuscode, se vir algum erro o dio nos da uma exception, com isso precisamos envolver o request com try-cat)
    try {
      //*HTTP
      // final responseData = jsonDecode(response.body);

      //*Dio(nao precisamos mais tratar o jsonDecode, pois agora meu response ja vem com uma informação (respose.data -> ele ja é um jsonDecode)
      //*o Dio ja faz isso por baixo dos panos fazendo essa conversão e retornando nosso objeto)
      if (response.data.isEmpty) {
        throw Exception("Produto não encontrado");
      }

      //*HTTP
      // return Course.fromMap(responseData.first);

      //*Dio
      return Course.fromMap(response.data.first);
    } on DioError {
      //*Aqui retoramos nossa exeception com o DioError como no http
      throw Exception();
    }
  }
}
