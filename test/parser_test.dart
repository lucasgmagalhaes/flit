import 'package:flit/flit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models/user.dart';

void main() {
  group("Insert querys", () {
    test('should create a insert query', () {
      User user = new User();
      user.name = "test";
      user.email = "test@email.com";
      String query = Parser.createQuery(QueryAction.insert, entity: user);
      expect(
          query,
          equals(
              "INSERT INTO USER(name,email) VALUES('test','test@email.com')"));
    });
  });

  group("Select querys", () {
    test("should create a select all query", () {
      String query = Parser.createQuery<User>(QueryAction.select);
      expect(query, equals("SELECT * FROM USER"));
    });
  });
}
