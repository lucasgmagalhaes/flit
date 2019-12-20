import 'package:flit/flit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_main_util.dart';

void main() {
  initializeResources();


  test("should open database connection", () async {
    String path = await buildDbPath("test.db");
    Connection.setDatabasePath(path);
    Connection.getDb();
  });
}
