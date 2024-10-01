import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/splash_screen.dart';
import 'package:parmosys_flutter/utils/strings.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: [
    GoRoute(
      path: initialRoute,
      builder: (_, __) => const SplashScreen(),
    ),
  ],
  initialLocation: initialRoute,
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (_, __) => const SplashScreen(),
  observers: [routeObserver],
  navigatorKey: navigatorKey,
);

final routeObserver = RouteObserver<ModalRoute<void>>();
