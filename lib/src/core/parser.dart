import 'package:dson/dson.dart';
import 'package:flu_entity/src/annotation.dart';
import 'parser.reflectable.dart';

void main() {
  initializeReflectable();
}

class Parser {
  static String createQuery<T>(Object entity, QueryAction queryType) {
    String query = queryType.name;

    // Map<dynamic, dynamic> objDeserializad = toMap(entity);

    // objDeserializad.keys.forEach((column) {
    //   query += "$column,";
    // });
    // query.substring(0, query.length - 2);

    // if (queryType == QueryAction.insert) {
    //   query += "VALUES (";
    // }

    // var colValues = objDeserializad.values;
    // colValues.forEach((value) {
    //   query += "$column,";
    // });
    // query.substring(0, query.length - 2);
    // query += ")";
    return toJson(entity);
    ///return query;
  }
}

enum QueryAction { insert, update, delete, select }

extension QueryActionExtension on QueryAction {
  String get name {
    switch (this) {
      case QueryAction.insert:
        return 'INSERT INTO';
      case QueryAction.update:
        return 'UPDATE';
      case QueryAction.select:
        return 'SELECT';
      case QueryAction.delete:
        return 'DELETE';
      default:
        return null;
    }
  }
}
