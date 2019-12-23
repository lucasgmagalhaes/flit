import 'package:flit/flit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_porter/src/utils.dart';
import 'package:tekartik_test_menu_flutter/test.dart';

import 'user.dart';

class UserService extends Service<User> {
  UserService(Connection con) : super(con);
}

void main() {
  UserService service;

  test("should run", () async {
    expect(1, equals(1));
  });

  test("should insert a User", () async {
    String path = await initEmptyDb("export.db");
    Database db = await openDatabase(path);

    Connection con = new Connection(database: db);

    service = new UserService(con);
    User user = new User();
    user.name = "testUser";
    user.email = "test@gmail.com";
    user = await service.save(user);
    expect(user.id, isNot(equals(0)));
  });
}
