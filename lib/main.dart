import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/translation_helper.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/main_page.dart';
import 'package:flutter_firebase_bloc_with_peter/route_generator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: OverlaySupport.global(
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            ScreenUtil.init(context);
            return GetMaterialApp(
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: DefaultScrollBehavior(),
                  child: DefaultUnfocus(child: child!),
                );
              },
              debugShowCheckedModeBanner: true,
              initialRoute: MainPage.route,
              navigatorKey: navigatorKey,
              title: 'Flutter Firebase Bloc',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS:
                        CupertinoWillPopScopePageTransionsBuilder(),
                  },
                ),
              ),
              translations: TranslationHelper(),
              onGenerateRoute: (settings) {
                return RouteGenerator.generateRoute(settings, context);
              },
            );
          },
        ),
      ),
    );
  }
}

class DefaultUnfocus extends StatelessWidget {
  const DefaultUnfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}

class DefaultScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
