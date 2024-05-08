import 'package:flutter/material.dart';
import 'package:web_routing/router/route_delegate.dart';
import 'package:web_routing/router/route_handeler.dart';
import 'package:web_routing/database/hive_storage_service.dart';

class MainScreen extends StatefulWidget {
  final String routeName;

  const MainScreen({
    super.key,
    required this.routeName,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? render;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(30)),
              child: TextButton(
                onPressed: () {
                  _logOut();
                },
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30)),
                child: TextButton(
                  onPressed: () {
                    CustomRouterDelegate().setPathName(RouteData.menu.name);
                  },
                  child: const Text(
                    'MENU',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30)),
                child: TextButton(
                  onPressed: () {
                    CustomRouterDelegate().setPathName(RouteData.profile.name);
                  },
                  child: const Text(
                    'PROFILE',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30)),
                child: TextButton(
                  onPressed: () {
                    CustomRouterDelegate().setPathName(RouteData.settings.name);
                  },
                  child: const Text(
                    'SETTINGS',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30)),
                child: TextButton(
                  onPressed: () {
                    CustomRouterDelegate().setPathName(RouteData.theme.name);
                  },
                  child: const Text(
                    'THEME',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    CustomRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
  }
}
