library example.object_to_map;
import 'package:dson/dson.dart';
import 'package:flu_entity/src/annotation.dart';

@serializable
class User {
  @identifier
  int id;
  @column
  String name;
  @column
  String email;
}