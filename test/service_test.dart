import 'package:flit/flit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/sqflite_test.dart';

import 'models/user.dart';
import 'test_main_util.dart';

class UserService extends Service<User> {
  UserService(Connection con) : super(con);
}

Future main() {
  return testMain(run);
}

void run(SqfliteServerTestContext context) {
  initializeResources();
  UserService service;

  test("should insert a User", () async {

    var factory = context.databaseFactory;
    String path = await context.initDeleteDb("test.sql");
    Database db = await factory.openDatabase(path);
    Connection con = new Connection(database: db);

    service = new UserService(con);
    User user = new User();
    user.name = "testUser";
    user.email = "test@gmail.com";
    user = await service.save(user);
    expect(user.id, isNot(equals(0)));
  });
}
