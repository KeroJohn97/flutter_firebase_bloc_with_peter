import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_bloc_with_peter/exception.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/home_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/login_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/main_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/message_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/signup_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/welcome_page.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case MessagePage.route:
        return customRoute(
            settings: settings,
            child: MessagePage(
                firestore: settings.arguments as FirebaseFirestore));
      case WelcomePage.route:
        return customRoute(settings: settings, child: const WelcomePage());
      case HomePage.route:
        return customRoute(settings: settings, child: const HomePage());
      case SignupPage.route:
        return customRoute(settings: settings, child: const SignupPage());
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
