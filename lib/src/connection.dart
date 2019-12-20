import 'package:sqflite/sqflite.dart';

class Connection {
  final String databasePath;
  Database database;

  Connection({this.databasePath, this.database});

  open() async {
   this.database = await openDatabase(this.databasePath);
  }

  Future<Database> _getDb() async {
    if (database == null) {
      this.database = await openDatabase(this.databasePath);
    }
    return this.database;
  }

  Future<void> close() async {
    Database db = await this._getDb();
    db.close();
  }

  Future run(String query) async {
    Database db = await this._getDb();
    db.query(query);
  }
}
