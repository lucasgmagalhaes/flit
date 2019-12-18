import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Connection {
  final String _databaseFileName;
  Database _db;
  Connection(this._databaseFileName);

  void start() async {
    if (this._db == null) {
      this._db = await openDatabase(
          join(await getDatabasesPath(), this._databaseFileName));
    }
  }

  Future<void> close() async {
    await this._db.close();
  }
  
}
