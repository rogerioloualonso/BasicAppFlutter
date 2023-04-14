import 'dart:math';
import 'package:exemplo/dao/enderecoDao.dart';
import 'package:exemplo/models/endereco.dart';
import 'package:flutter/material.dart';

class EnderecosProvider with ChangeNotifier {
  List<Endereco> _items = [];

  EnderecosProvider() {
    EnderecoDao().getAllEnderecos().then((enderecos) {
      _items = enderecos.values.toList();
      notifyListeners();
    });
  }

  List<Endereco> get all {
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  Endereco byIndex(int i) {
    return _items.elementAt(i);
  }

  Future<void> put(Endereco endereco) async {
    if (endereco == null) {
      return;
    }

    final dao = EnderecoDao();

    if (_items.any((e) => e.id == endereco.id)) {
      await dao.updateEndereco(endereco);
      _items[_items.indexWhere((e) => e.id == endereco.id)] = Endereco(
        id: endereco.id,
        descricao: endereco.descricao,
        cep: endereco.cep,
        rua: endereco.rua,
        numero: endereco.numero,
        complemento: endereco.complemento,
        bairro: endereco.bairro,
        municipio: endereco.municipio,
        estado: endereco.estado,
      );
    } else {
      final id = Random().nextInt(100).toString();

      Endereco temp = Endereco(
        id: id,
        descricao: endereco.descricao,
        cep: endereco.cep,
        rua: endereco.rua,
        numero: endereco.numero,
        complemento: endereco.complemento,
        bairro: endereco.bairro,
        municipio: endereco.municipio,
        estado: endereco.estado,
      );
      await dao.insertEndereco(temp);
      _items.add(temp);
    }

    notifyListeners();
  }

  void remove(Endereco endereco) async {
    if (endereco != null && endereco.id != null) {
      EnderecoDao dao = EnderecoDao();
      await dao.deleteEndereco(endereco.id);

      _items = await dao.getAllEnderecos().then((enderecos) {
        return _items = enderecos.values.toList();
      });

      notifyListeners();
    }
  }
}
