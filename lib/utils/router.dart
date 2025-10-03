import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/area/area_page.dart';
import 'package:parmosys_flutter/feature/category/category_page.dart';
import 'package:parmosys_flutter/feature/parking_space/parking_space_page.dart';
import 'package:parmosys_flutter/feature/start/start_page.dart';

part 'router.g.dart';

final router = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (_, __) => const StartPage(),
  observers: [RouteObserver<ModalRoute<void>>()],
);

@TypedGoRoute<StartRoute>(path: '/')
class StartRoute extends GoRouteData with $StartRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StartPage();
  }
}

@TypedGoRoute<CategoryRoute>(
  path: '/category',
  routes: [
    TypedGoRoute<AreaRoute>(
      path: 'area',
      routes: [
        TypedGoRoute<ParkingSpaceRoute>(
          path: 'parking-space',
        )
      ],
    )
  ],
)
class CategoryRoute extends GoRouteData with $CategoryRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CategoryPage();
  }
}

class AreaRoute extends GoRouteData with $AreaRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AreaPage();
  }
}

class ParkingSpaceRoute extends GoRouteData with $ParkingSpaceRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ParkingSpacePage();
  }
}
