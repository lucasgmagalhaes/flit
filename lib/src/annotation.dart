import 'package:dson/dson.dart';

class Table extends Serializable {
  final String name;
  const Table({this.name});
}

class Column extends Serializable {
  final String name;
  const Column({this.name});
}

class Identifier extends Serializable {
  const Identifier();
}

const identifier = const Identifier();
const column = const Column();
const table = const Table();