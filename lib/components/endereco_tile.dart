import 'package:exemplo/models/endereco.dart';
import 'package:exemplo/provider/enderecos.dart';
import 'package:exemplo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnderecoTile extends StatelessWidget {
  final Endereco endereco;

  const EnderecoTile(this.endereco);

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      child: Icon(Icons.house_outlined),
    );

    return ListTile(
        leading: avatar,
        title: Text(endereco.descricao),
        subtitle: Text(endereco.rua),
        trailing: Container(
          width: 100,
          child: Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.ENDERECO_FORM, arguments: endereco);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Usuário'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Não'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Enderecos>(context, listen: false)
                        .remove(endereco);
                  }
                });
              },
            )
          ]),
        ));
  }
}
