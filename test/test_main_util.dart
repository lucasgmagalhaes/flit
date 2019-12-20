import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void initializeResources() {
  WidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
 
  // const MethodChannel channelSqflite = MethodChannel('com.tekartik.sqflite');
  // channelSqflite.setMockMethodCallHandler((MethodCall methodCall) async {
  //   return databaseFactoryMock;
  // });
}

Future<String> buildDbPath(String dbName) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  return join(documentsDirectory.path, dbName);
}

