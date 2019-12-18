import 'package:json_annotation/json_annotation.dart';

class Table extends JsonSerializable {
  const Table() : super();
}

class Column extends JsonKey {
  const Column({String name}) : super(name: name);
}

class Identifier extends JsonSerializable {
  const Identifier();
}