import 'dart:math';
import 'package:exemplo/data/dummy_endereco.dart';
import 'package:exemplo/models/endereco.dart';
import 'package:flutter/material.dart';

class Enderecos with ChangeNotifier {
  Map<String, Endereco> _items = {...DUMMY_ENDERECO};

  List<Endereco> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Endereco byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Endereco endereco) {
    if (endereco == null) {
      return;
    }

    if (endereco.id != null &&
        !endereco.id.trim().isEmpty &&
        _items.containsKey(endereco.id)) {
      _items.update(
        endereco.id,
        (_) => Endereco(
            id: endereco.id,
            descricao: endereco.descricao,
            cep: endereco.cep,
            rua: endereco.rua,
            numero: endereco.numero,
            complemento: endereco.complemento,
            bairro: endereco.bairro,
            municipio: endereco.municipio,
            estado: endereco.estado),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => Endereco(
            id: id,
            descricao: endereco.descricao,
            cep: endereco.cep,
            rua: endereco.rua,
            numero: endereco.numero,
            complemento: endereco.complemento,
            bairro: endereco.bairro,
            municipio: endereco.municipio,
            estado: endereco.estado),
      );
    }

    notifyListeners(); //Notifica que teve alteração
  }

  void remove(Endereco endereco) {
    if (endereco != null && endereco.id != null) {
      _items.remove(endereco.id);
      notifyListeners();
    }
  }
}
