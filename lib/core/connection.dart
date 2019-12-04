import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  final String _database;

  Connection(this._database);

  void start() async {
    final Database database =
       await openDatabase(join(await getDatabasesPath(), this._database));
  }

  void close() {

  }
}
