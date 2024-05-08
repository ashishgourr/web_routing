import 'package:flutter/material.dart';
import 'package:web_routing/router/route_path.dart';

class CustomRoutesInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.path);

    if (uri.pathSegments.isEmpty) {
      return RoutePath.home('/');
    }
    if (uri.queryParameters.isNotEmpty) {
      return RoutePath.otherPage(
          routeInformation.uri.path.replaceFirst("/", ""));
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();

      return RoutePath.otherPage(pathName);
    } else if (uri.pathSegments.length == 2) {
      final complexPath =
          "${uri.pathSegments.elementAt(0)}/${uri.pathSegments.elementAt(1)}";
      return RoutePath.otherPage(complexPath.toString());
    } else {
      return RoutePath.otherPage(uri.pathSegments.toString());
    }
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(uri: Uri(path: '/error'));
    }
    if (configuration.isHomePage) {
      return RouteInformation(uri: Uri(path: '/'));
    }
    if (configuration.isOtherPage) {
      return RouteInformation(uri: Uri(path: '/${configuration.pathName}'));
    }

    return RouteInformation(uri: Uri(path: null));
  }
}
