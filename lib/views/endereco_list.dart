import 'package:exemplo/components/endereco_tile.dart';
import 'package:exemplo/provider/enderecosProvider.dart';
import 'package:exemplo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnderecoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EnderecosProvider enderecos = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Meus Endereços'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.ENDERECO_FORM);
                })
          ],
        ),
        body: ListView.builder(
          itemCount: enderecos.count,
          itemBuilder: (ctx, i) => EnderecoTile(enderecos.byIndex(i)),
        ));
  }
}
