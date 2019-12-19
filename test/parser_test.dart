import 'package:flit/flit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models/user.dart';

void main() {
  String testEmail = "g@email.com";
  String testName = "testName";
  int testId = 2;

  group("Insert querys", () {
    test('should create a insert query', () {
      User user = new User();
      user.name = "test";
      user.email = "test@email.com";
      String query = Parser.createInsertQuery(user);
      expect(
          query,
          equals(
              "INSERT INTO USER(name,email) VALUES('test','test@email.com')"));
    });
  });

  group("Select querys", () {
    test("should throw EntityTypeMissing because it was not informed", () {
      try {
        Parser.createSelectQuery(null);
        fail("Parser did not throws an exception");
      } catch (exception) {
        expect(exception.runtimeType, equals(EntityTypeMissing));
      }
    });

    test("should create a select all query", () {
      String query = Parser.createSelectQuery(User);
      expect(query, equals("SELECT * FROM USER"));
    });

    test("should createa a select with single filter(string)", () {
      String query =
          Parser.createSelectQueryWithFilter([Criteria("name", "test")], User);
      expect(query, equals("SELECT * FROM USER WHERE NAME = 'test'"));
    });

    test("should createa a select with double filter(both strings)", () {
      String query = Parser.createSelectQueryWithFilter(
          [Criteria("name", "test"), Criteria("email", "test@gmail.com")],
          User);
      expect(
          query,
          equals(
              "SELECT * FROM USER WHERE NAME = 'test' AND EMAIL = 'test@gmail.com'"));
    });

    test("should createa a select with single filter number", () {
      String query =
          Parser.createSelectQueryWithFilter([Criteria("id", 1)], User);
      expect(query, equals("SELECT * FROM USER WHERE ID = 1"));
    });
  });

  group("Group update", () {
    test("should all fields", () {
      User user = new User();
      user.email = testEmail;
      user.name = testName;
      user.id = testId;

      String query = Parser.createUpdateQuery(user);
      expect(
          query,
          equals(
              "UPDATE USER SET NAME = '$testName' AND EMAIL = '$testEmail' WHERE ID = $testId"));
    });

    test(
        "should throw exception UpdateNotExistingEntityError because is trying to insert a entity with no ID",
        () {
      User user = new User();
      user.email = testEmail;
      user.name = testName;

      try {
        Parser.createUpdateQuery(user);
        fail(
            "Fail beacause Parser created a update query for a no existing entity");
      } catch (exception) {
        expect(exception.runtimeType, equals(UpdateNotExistingEntityError));
      }
    });
  });
}
