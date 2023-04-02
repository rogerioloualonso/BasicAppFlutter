import 'package:exemplo/data/dummy_user.dart';
import 'package:exemplo/models/user.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }
}
