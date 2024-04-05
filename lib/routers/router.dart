import "package:auto_route/annotations.dart";
import "package:auto_route/auto_route.dart";
import "package:znotes/routers/router.gr.dart";
import "package:znotes/screens/FavoritesScreen.dart";
import "package:znotes/screens/NoteEditScreen.dart";

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: NoteEditRoute.page),
        AutoRoute(page: FavoritesRoute.page)
      ];
}
