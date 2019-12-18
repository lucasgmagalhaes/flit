import 'dart:convert';

class Parser {
  static String createQuery<T>(Object entity, QueryAction queryType) {
    String query = queryType.name;

    if (queryType == QueryAction.insert) {
      query += " " + entity.runtimeType.toString().toUpperCase() + "(";
    }

    String objEncoded = json.encode(entity);
    Map<dynamic, dynamic> objDeserializad = json.decode(objEncoded);

    objDeserializad.keys.forEach((column) {
      if (column != "id") {
        query += "$column,";
      }
    });

    query = query.substring(0, query.length - 1);
    query += ")";

    if (queryType == QueryAction.insert) {
      query += " VALUES(";
    }

    var colValues = objDeserializad.values;

    for (int i = 0; i < colValues.length; i++) {
      if (i != 0) {
        dynamic element = colValues.elementAt(i);
        if (element is String) {
          query += "'$element',";
        } else {
          query += "$element',";
        }
      }
    }

    query = query.substring(0, query.length - 1);
    query += ")";

    return query;
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
