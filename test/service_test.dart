import 'package:flit/flit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models/user.dart';
import 'test_main_util.dart';

class UserService extends Service<User> {
  UserService(Connection con) : super(con);
}

void main() {
  initializeResources();
  UserService service;

  Future<void> connectToDb() async {
    String path = await buildDbPath("test.db");
    Connection con = new Connection(path);
    service = new UserService(con);
  }

  test("should insert a User", () async {
    User user = new User();
    user.name = "testUser";
    user.email = "test@gmail.com";
    await connectToDb();
    user = await service.save(user);
    expect(user.id, isNot(equals(0)));
  });
}
