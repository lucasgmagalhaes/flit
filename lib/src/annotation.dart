import 'package:reflectable/reflectable.dart';

class _Column extends Reflectable {
  final String name;
  const _Column({this.name}) : super(invokingCapability);
}

class _PrimaryKey extends Reflectable {
  final String columnName;
   const _PrimaryKey({this.columnName}) : super(invokingCapability);
}

class _Table extends Reflectable {
  final String name;
  const _Table({this.name}) : super(invokingCapability);
}

const table = const _Table();
const column = const _Column();
const primaryKey = const _PrimaryKey();