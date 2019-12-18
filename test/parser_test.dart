import 'package:flu_entity/src/core/parser.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models/user.dart';

void main() {
  test('should create a insert query', () {
    User user = new User();
      user.name = "test";
      user.email = "test@email.com";
      String query = Parser.createQuery(user, QueryAction.insert);
      expect(query, equals("INSERT INTO USER(name,email) VALUES('test','test@email.com')")); 
  });
}
