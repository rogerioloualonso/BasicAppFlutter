import 'package:exemplo/models/endereco.dart';
import 'package:exemplo/provider/enderecos.dart';
import 'package:exemplo/service/enderecoService.dart';
import 'package:exemplo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exemplo/routes/app_routes.dart';

class EnderecoForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<EnderecoForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(Endereco endereco) {
    if (endereco != null) {
      _formData['id'] = endereco.id;
      _formData['descricao'] = endereco.descricao;
      _formData['cep'] = endereco.cep;
      _formData['rua'] = endereco.rua;
      _formData['numero'] = endereco.numero;
      _formData['complemento'] = endereco.complemento;
      _formData['bairro'] = endereco.bairro;
      _formData['municipio'] = endereco.municipio;
      _formData['estado'] = endereco.estado;
    } else {
      _formData['id'] = '';
      _formData['descricao'] = '';
      _formData['cep'] = '';
      _formData['rua'] = '';
      _formData['numero'] = '';
      _formData['complemento'] = '';
      _formData['bairro'] = '';
      _formData['municipio'] = '';
      _formData['estado'] = '';
    }
    _atualizarForm();
  }

  TextEditingController controllerRua = TextEditingController();
  TextEditingController controllerBairro = TextEditingController();
  TextEditingController controllerMunicipio = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();

  void _atualizarForm() {
    setState(() {
      controllerRua.text = _formData['rua'].toString();
      controllerBairro.text = _formData['bairro'].toString();
      controllerMunicipio.text = _formData['municipio'].toString();
      controllerEstado.text = _formData['estado'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final enderecoTest = ModalRoute.of(context)?.settings.arguments;

    if (enderecoTest != null) {
      final endereco = ModalRoute.of(context)!.settings.arguments as Endereco;
      _loadFormData(endereco);
    }

    return Scaffold(
        appBar: AppBar(title: Text('Cadastro'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState?.save();
                Provider.of<Enderecos>(context, listen: false).put(
                  Endereco(
                    id: _formData['id'] == null ? '' : _formData['id']!,
                    descricao: _formData['descricao']!,
                    cep: _formData['cep']!,
                    rua: _formData['rua']!,
                    numero: _formData['numero']!,
                    complemento: _formData['complemento']!,
                    bairro: _formData['bairro']!,
                    municipio: _formData['municipio']!,
                    estado: _formData['estado']!,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          )
        ]),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _form,
              child: ListView(children: <Widget>[
                TextFormField(
                  initialValue: _formData['descricao'],
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Descrição inválida';
                    }
                    if (value.trim().length <= 3) {
                      return 'Descrição muito pequena, no mínimo 3 letras.';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['descricao'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['cep'],
                  decoration: InputDecoration(labelText: 'cep'),
                  onSaved: (value) => _formData['cep'] = value!,
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _form.currentState?.save();
                    String cep = _formData['cep']!;
                    if (Utils.validarCEP(cep)) {
                      Endereco enderecoResult =
                          await EnderecoService().buscarEnderecoPorCEP(cep);
                      if (enderecoResult.descricao == 'erro') {
                        _ModalErroCEP();
                      } else {
                        _loadFormData(enderecoResult);
                        _atualizarForm();
                      }
                    } else {
                      _ModalErroCEP();
                    }
                  },
                  child: Text('Buscar CEP'),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(10, 35))),
                ),
                TextFormField(
                  controller: controllerRua..text,
                  decoration: InputDecoration(labelText: 'rua'),
                  onSaved: (value) => _formData['rua'] = value!,
                  enabled: false,
                ),
                TextFormField(
                  controller: controllerBairro..text,
                  decoration: InputDecoration(labelText: 'bairro'),
                  onSaved: (value) => _formData['bairro'] = value!,
                  enabled: false,
                ),
                TextFormField(
                  controller: controllerMunicipio..text,
                  decoration: InputDecoration(labelText: 'municipio'),
                  onSaved: (value) => _formData['municipio'] = value!,
                  enabled: false,
                ),
                TextFormField(
                  controller: controllerEstado..text,
                  decoration: InputDecoration(labelText: 'estado'),
                  onSaved: (value) => _formData['estado'] = value!,
                  enabled: false,
                ),
                TextFormField(
                  initialValue: _formData['numero'],
                  decoration: InputDecoration(labelText: 'numero'),
                  onSaved: (value) => _formData['numero'] = value!,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  initialValue: _formData['complemento'],
                  decoration: InputDecoration(labelText: 'complemento'),
                  onSaved: (value) => _formData['complemento'] = value!,
                  keyboardType: TextInputType.number,
                )
              ])),
        ));
  }

  Future<void> _ModalErroCEP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro!'),
          backgroundColor: Color.fromARGB(255, 254, 197, 127),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Ocorreu um dos erros a seguir:'),
                Text(' '),
                Text('- CEP fora do padrão esperado.'),
                Text('- CEP inválido.'),
                Text('- CEP não encontrado.')
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 254, 197, 127),
                backgroundColor: Colors.white,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
