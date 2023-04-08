import 'package:dio/dio.dart';
import 'package:exemplo/models/endereco.dart';
import 'package:flutter/material.dart';

class EnderecoService {
  final dio = Dio();

  final prefixUrl = 'https://viacep.com.br/ws/';
  final sufixUrl = '/json/';

  buscarEnderecoPorCEP(cep) async {
    Response response = await dio.get(prefixUrl + cep + sufixUrl);
    //return response.data;

    Map<String, dynamic> data = response.data;

    if (response.statusCode == 200) {
      bool erro = data["erro"] == null ? false : data["erro"];

      if (!erro) {
        Endereco endereco = Endereco(
            descricao: '',
            cep: data["cep"],
            rua: data["logradouro"],
            numero: '',
            complemento: '',
            bairro: data["bairro"],
            municipio: data["localidade"],
            estado: data["uf"]);

        return endereco;
      } else {
        Endereco endereco = Endereco(
          descricao: 'erro',
          cep: '',
          rua: '',
          numero: '',
          complemento: '',
          bairro: '',
          municipio: '',
          estado: '',
        );

        return endereco;
      }
    } else {
      throw Exception('Erro de requisição');
    }
  }
}
