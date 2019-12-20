import 'package:flit/flit.dart';

class Service<T> {
  Connection _con;

  Service(this._con);

  T get(T entity) {}
  T getById(Object id) {}
  List<T> getAll() {}
  Future<T> save(T entity) async {
    String query = Parser.createInsertQuery(entity);
    return await _con.run(query);
  }

  Future<T> update(T entity) async {
    String query = Parser.createUpdateQuery(entity);
    return await _con.run(query);
  }

  T saveOrUpdate(T entity) {}
  T delete(T entity) {}
  T deleteById(Object id) {}
}
