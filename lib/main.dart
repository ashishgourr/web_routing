import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_routing/router/route_delegate.dart';

import 'router/route_information_parser.dart';
import 'database/hive_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }

  bool isUserLoggedIn = await HiveDataStorageService.getUser();

  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Web Routing 2.0',
    routeInformationParser: CustomRoutesInformationParser(),
    routerDelegate: CustomRouterDelegate(isLoggedIn: isUserLoggedIn),
  ));
}
