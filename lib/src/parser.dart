import 'dart:convert';

import 'package:flit/src/exceptions.dart';

import 'criteria.dart';

class Parser {
  static String createUpdateQuery(Object entity) {
    String query = "UPDATE ${entity.runtimeType.toString().toUpperCase()} SET ";
    var map = _convertEntityToMap(entity);
    List<Criteria> criterias = _convertMapToCriteria(map);
    Criteria idCriteria = criterias.firstWhere((criteria) {
      return criteria.field == "id";
    });

    if (idCriteria.value == null) {
      throw new UpdateNotExistingEntityError(entity.runtimeType);
    }

    int id = idCriteria.value;
    criterias.remove(idCriteria);
    query += _convertCriteriaToStringQuery(criterias);
    query += " WHERE ID = $id";
    return query;
  }

  static String createSelectQueryWithFilter(
      List<Criteria> criterias, Type entityType) {
    String query = "${createSelectQuery(entityType)} ";
    query += "WHERE ${_convertCriteriaToStringQuery(criterias)}";
    return query;
  }

  static String _convertCriteriaToStringQuery(List<Criteria> criterias) {
    String criteriaString = "";
    criterias.forEach((criteria) {
      criteriaString +=
          "${criteria.field.toUpperCase()} = ${_getValueRespectiveString(criteria.value)} AND ";
    });

    return criteriaString.substring(0, criteriaString.length - 5);
  }

  static String createSelectQuery(Type entityType, {Object entity}) {
    if (entityType == null) {
      throw new EntityTypeMissing();
    }

    String query = QueryAction.select.name + " ";
    String tableName;

    if (entity != null) {
      var objDeserializad = _convertEntityToMap(entity);
      query += _createColumnsString(objDeserializad.keys);
      tableName = entity.runtimeType.toString().toUpperCase();
    } else {
      query += "*";
      tableName = entityType.toString().toUpperCase();
    }

    query += " FROM ";
    query += tableName;
    return query;
  }

  static List<Criteria> _convertMapToCriteria(Map<dynamic, dynamic> map) {
    List<Criteria> criterias = new List<Criteria>();
    map.forEach((key, value) {
      criterias.add(Criteria(key, value));
    });
    return criterias;
  }

  static String createInsertQuery(Object entity) {
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
        stringValues += "${_getValueRespectiveString(element)},";
      }
    }

    return stringValues.substring(0, stringValues.length - 1);
  }

  static String _getValueRespectiveString(dynamic value) {
    if (value is String) {
      return "'$value'";
    }
    return value.toString();
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
