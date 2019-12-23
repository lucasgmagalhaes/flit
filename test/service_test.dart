import 'package:flit/flit.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/sqflite_test.dart';
import 'package:tekartik_test_menu_flutter/test.dart';
import 'models/user.dart';
import 'test_main_util.dart';
import 'package:sqflite_porter/src/utils.dart';
import './sqflite_server_app/lib/src/test/server_main.dart' as server;
import './sqflite_server_app/lib/main.dart';

class UserService extends Service<User> {
  UserService(Connection con) : super(con);
}

Future main() {
  Navigator.of(buildContext).push<dynamic>(homePageRoute);
  server.main();
  return testMain(run);
}

void run(SqfliteServerTestContext context) {
  initializeResources();
  UserService service;

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
