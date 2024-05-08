import 'package:flutter/material.dart';
import 'package:web_routing/database/hive_storage_service.dart';
import 'package:web_routing/router/custom_transition_delegate.dart';
import 'package:web_routing/router/route_handeler.dart';
import 'package:web_routing/router/route_path.dart';
import 'package:web_routing/screens/login_screen.dart';
import 'package:web_routing/screens/main_screen.dart';
import 'package:web_routing/screens/theme_screen.dart';
import 'package:web_routing/screens/profile_screen.dart';
import 'package:web_routing/screens/settings_screen.dart';
import 'package:web_routing/screens/unknown.dart';

import '../screens/menu_screen.dart';

class CustomRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final CustomRouterDelegate _instance = CustomRouterDelegate._();
  bool? isLoggedIn;
  String? pathName;
  bool isError = false;

  factory CustomRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;
    return _instance;
  }
  CustomRouterDelegate._();
  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  late List<Page> _stack = [];

  @override
  RoutePath get currentConfiguration {
    if (isError) {
      return RoutePath.unknown();
    }
    if (pathName == null) return RoutePath.home('splash');

    return RoutePath.otherPage(pathName);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  List<Page> get _homeStack => [
        MaterialPage(
          key: const ValueKey('home'),
          child: MainScreen(
            routeName: pathName ?? RouteData.home.name,
          ),
        ),
      ];

  List<Page> get _profileStack => [
        const MaterialPage(
          key: ValueKey('profile'),
          child: ProfileScreen(),
        ),
      ];

  List<Page> get _settingsStack => [
        const MaterialPage(
          key: ValueKey('settings'),
          child: SettingsScreen(),
        ),
      ];

  List<Page> get _menuStack => [
        const MaterialPage(
          key: ValueKey('menu'),
          child: MenuScreen(),
        )
      ];

  List<Page> get _themeStack => [
        const MaterialPage(
          key: ValueKey('theme'),
          child: ThemeScreen(),
        )
      ];

  List<Page> get _authStack => [
        MaterialPage(
          key: const ValueKey('login'),
          child: LoginScreen(),
        ),
      ];

  List<Page> get _unknownRoute => [
        const MaterialPage(
          key: ValueKey('unknown'),
          child: UnknownScreen(),
        )
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      switch (pathName) {
        case 'menu':
          _stack = _menuStack;
          break;
        case 'profile':
          _stack = _profileStack;
          break;
        case 'settings':
          _stack = _settingsStack;
          break;
        case 'theme':
          _stack = _themeStack;
          break;
        default:
          _stack = _homeStack;
      }
    } else if ((isLoggedIn == false)) {
      _stack = _authStack;
    } else {
      _stack = _unknownRoute;
    }

    return Navigator(
      transitionDelegate: transitionDelegate,
      key: navigatorKey,
      pages: _stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        pathName = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    bool isLoggedIn = await HiveDataStorageService.getUser();

    pathName = configuration.pathName;

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          if (configuration.pathName == RouteData.login.name) {
            pathName = RouteData.home.name;
            isError = false;
          } else {
            pathName = configuration.pathName != RouteData.login.name
                ? configuration.pathName
                : RouteData.home.name;
            isError = false;
          }
        } else {
          pathName = RouteData.login.name;

          isError = false;
        }
      } else {
        pathName = configuration.pathName;
        isError = false;
      }
    } else {
      pathName = "/";
    }
    notifyListeners();
  }

  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }
}
