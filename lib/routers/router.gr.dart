// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:znotes/screens/FavoritesScreen.dart' as _i1;
import 'package:znotes/screens/HomeScreen.dart' as _i2;
import 'package:znotes/screens/NoteCreationPage.dart' as _i3;
import 'package:znotes/screens/NoteViewingPage.dart' as _i4;
import 'package:znotes/utils/content_types.dart' as _i7;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    FavoritesRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FavoritesPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    NoteCreationRoute.name: (routeData) {
      final args = routeData.argsAs<NoteCreationRouteArgs>(
          orElse: () => const NoteCreationRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.NoteCreationPage(
          key: args.key,
        ),
      );
    },
    NoteEditRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.NoteEditScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.FavoritesPage]
class FavoritesRoute extends _i5.PageRouteInfo<void> {
  const FavoritesRoute({List<_i5.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NoteCreationPage]
class NoteCreationRoute extends _i5.PageRouteInfo<NoteCreationRouteArgs> {
  NoteCreationRoute({
    _i6.Key? key,
    _i7.Note? note,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          NoteCreationRoute.name,
          args: NoteCreationRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteCreationRoute';

  static const _i5.PageInfo<NoteCreationRouteArgs> page =
      _i5.PageInfo<NoteCreationRouteArgs>(name);
}

class NoteCreationRouteArgs {
  const NoteCreationRouteArgs({
    this.key,
    this.note,
  });

  final _i6.Key? key;

  final _i7.Note? note;

  @override
  String toString() {
    return 'NoteCreationRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [_i4.NoteEditScreen]
class NoteEditRoute extends _i5.PageRouteInfo<void> {
  const NoteEditRoute({List<_i5.PageRouteInfo>? children})
      : super(
          NoteEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoteEditRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
