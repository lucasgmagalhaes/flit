import 'package:sqflite_server/sqflite_server.dart';
import 'package:tekartik_test_menu/test.dart';

void main() {
  menu('server', () {
    SqfliteServer server;
    item('start', () async {
      if (server == null) {
        server = await SqfliteServer.serve(port: defaultPort);
      }
    });
    item('stop', () async {
      await server?.close();
      server = null;
    });
  });
}
int defaultPort = sqfliteServerDefaultPort;
