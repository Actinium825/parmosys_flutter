import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/area/area_page.dart';
import 'package:parmosys_flutter/feature/category/category_page.dart';
import 'package:parmosys_flutter/feature/splash_screen.dart';
import 'package:parmosys_flutter/utils/strings.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: [
    GoRoute(
      path: initialRoute,
      name: initialRoute,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: CategoryPage.route,
      name: CategoryPage.route,
      builder: (_, __) => const CategoryPage(),
      routes: [
        GoRoute(
          path: AreaPage.route,
          name: AreaPage.route,
          builder: (_, __) => const AreaPage(),
        ),
      ],
    ),
  ],
  initialLocation: initialRoute,
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (_, __) => const SplashScreen(),
  observers: [routeObserver],
  navigatorKey: navigatorKey,
);

final routeObserver = RouteObserver<ModalRoute<void>>();
