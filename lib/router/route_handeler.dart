import 'package:flutter/material.dart';
import 'package:web_routing/screens/menu_screen.dart';

import '../screens/home_screen.dart';
import '../screens/theme_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/unknown.dart';

enum RouteData {
  profile,
  login,
  home,
  menu,
  theme,
  settings,
  unkownRoute,
  notFound,
}

class RouteHandeler {
  static final RouteHandeler _instance = RouteHandeler._();
  factory RouteHandeler() => _instance;
  RouteHandeler._();

  Widget getRouteWidget(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();

        routeData = RouteData.values.firstWhere(
            (element) => element.name == pathName,
            orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.home:
              return const HomeScreen();

            case RouteData.menu:
              return const MenuScreen();

            case RouteData.profile:
              return const ProfileScreen();

            case RouteData.settings:
              return const SettingsScreen();

            case RouteData.theme:
              return const ThemeScreen();

            default:
              return const HomeScreen();
          }
        } else {
          return const UnknownScreen();
        }
      } else {
        return const HomeScreen();
      }
    } else {
      return const UnknownScreen();
    }
  }
}
