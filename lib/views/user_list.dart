import 'package:exemplo/components/user_tile.dart';
import 'package:exemplo/data/dummy_user.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const users = {...DUMMY_USERS};

    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Usários'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () {})
          ],
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, i) => UserTile(users.values.elementAt(i)),
        ));
  }
}
