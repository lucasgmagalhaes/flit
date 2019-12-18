import 'dart:convert';

class Parser {
  static String createQuery<T>(QueryAction queryAction, {Object entity}) {
    if (queryAction == QueryAction.insert) {
      return _createInsertQuery(entity);
    } else if (queryAction == QueryAction.select) {
      return _createSelectQuery<T>();
    } else {
      return "";
    }
  }

  /// Helper for generic type get
  static Type typeOf<T>() => T;

  static String _createSelectQuery<T extends Object>({Object entity}) {
    String query = QueryAction.select.name + " ";
    String tableName;

    if (entity != null) {
      var objDeserializad = _convertEntityToMap(entity);
      query += _createColumnsString(objDeserializad.keys);
      tableName = entity.runtimeType.toString().toUpperCase();
    } else {
      query += "*";
      Type type = typeOf<T>();
      tableName = type.toString().toUpperCase();
    }

    query += " FROM ";
    query += tableName;
    return query;
  }

  static String _createInsertQuery(Object entity) {
    String query = QueryAction.insert.name;

    query += " " + entity.runtimeType.toString().toUpperCase() + "(";

    var objDeserializad = _convertEntityToMap(entity);
    query += _createColumnsString(objDeserializad.keys, exceptions: ["id"]);

    query += ")";
    query += " VALUES(";

    var colValues = objDeserializad.values;
    query += _createColumnsValuesString(colValues, [0]);

    query += ")";
    return query;
  }

  static Map<dynamic, dynamic> _convertEntityToMap(Object entity) {
    String objEncoded = json.encode(entity);
    return json.decode(objEncoded);
  }

  static String _createColumnsString(Iterable<dynamic> values,
      {List<String> exceptions}) {
    String stringValues = "";

    values.forEach((column) {
      if (!exceptions.contains(column)) {
        stringValues += "$column,";
      }
    });
    return stringValues.substring(0, stringValues.length - 1);
  }

  static String _createColumnsValuesString(
      Iterable<dynamic> values, List<int> indexExceptions) {
    String stringValues = "";

    for (int i = 0; i < values.length; i++) {
      if (!indexExceptions.contains(i)) {
        dynamic element = values.elementAt(i);
        if (element is String) {
          stringValues += "'$element',";
        } else {
          stringValues += "$element',";
        }
      }
    }

    return stringValues.substring(0, stringValues.length - 1);
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
