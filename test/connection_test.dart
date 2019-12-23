import 'package:flit/flit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_porter/src/utils.dart';

import 'test_main_util.dart';

void main() {
  initializeResources();

  test("should open database connection", () async {
    String path = await initEmptyDb("export.db");
    Database db = await openDatabase(path);

    Connection con = new Connection(database: db);
    con.open();
  });
}
