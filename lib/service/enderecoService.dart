import 'dart:convert';

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
  }
}
