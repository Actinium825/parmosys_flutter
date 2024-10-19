import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/area/area_page.dart';
import 'package:parmosys_flutter/feature/category/category_page.dart';
import 'package:parmosys_flutter/feature/parking_space/parking_space_page.dart';
import 'package:parmosys_flutter/feature/start/start_page.dart';
import 'package:parmosys_flutter/utils/strings.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: [
    GoRoute(
      path: initialRoute,
      name: initialRoute,
      builder: (_, __) => const StartPage(),
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
          routes: [
            GoRoute(
              path: ParkingSpacePage.route,
              name: ParkingSpacePage.route,
              builder: (_, __) => const ParkingSpacePage(),
            ),
          ],
        ),
      ],
    ),
  ],
  initialLocation: initialRoute,
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (_, __) => const StartPage(),
  observers: [routeObserver],
  navigatorKey: navigatorKey,
);

final routeObserver = RouteObserver<ModalRoute<void>>();
