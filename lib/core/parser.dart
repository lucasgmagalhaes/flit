import 'package:flu_entity/src/annotation.dart';
import 'package:reflectable/reflectable.dart';

class Parser {
  String createQuery<T>(Object entity, QueryAction queryType){
    String query = queryType.name;();
    InstanceMirror instanceMirror = table.reflect(entity);
  }

}

enum QueryAction {
  insert,
  update,
  delete,
  select
}

extension QueryActionExtension on QueryAction {

  String get name {
    switch (this) {
      case QueryAction.insert:
        return 'INSERT';
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


