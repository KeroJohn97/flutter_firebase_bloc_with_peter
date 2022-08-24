import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_bloc_with_peter/exception.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/login_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/main_page.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case LoginPage.route:
        return customRoute(settings: settings, child: const LoginPage());
      case MainPage.route:
        return customRoute(settings: settings, child: const MainPage());
    }
    throw const RouteException('Route not found');
  }
}

Route customRoute({
  required RouteSettings settings,
  required Widget child,
}) {
  if (Platform.isIOS || Platform.isMacOS) {
    return CupertinoPageRoute(builder: (context) => child);
  }
  return MaterialPageRoute(builder: (context) => child);
}
