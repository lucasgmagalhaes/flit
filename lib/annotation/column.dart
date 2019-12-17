import 'package:reflectable/reflectable.dart';

class Column extends Reflectable {
  final String name;
  const Column([this.name]) : super(invokingCapability);
}
