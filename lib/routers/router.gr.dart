// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:znotes/screens/FavoritesScreen.dart' as _i1;
import 'package:znotes/screens/HomeScreen.dart' as _i2;
import 'package:znotes/screens/NoteEditScreen.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    FavoritesRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FavoritesPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    NoteEditRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.NoteEditScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.FavoritesPage]
class FavoritesRoute extends _i4.PageRouteInfo<void> {
  const FavoritesRoute({List<_i4.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NoteEditScreen]
class NoteEditRoute extends _i4.PageRouteInfo<void> {
  const NoteEditRoute({List<_i4.PageRouteInfo>? children})
      : super(
          NoteEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoteEditRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
