import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poloniex_app/core/routes/routes.dart';

/// The [AppRouter] class is responsible for managing the application's routes.
/// It combines the [AuthRoute], [HomeRoute] classes to define the available routes.
class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  AppRouter._internal();

  /// Returns the [GoRouter] instance used for navigation.
  GoRouter get router => _goRouter;

  /// Returns the current [BuildContext] associated with the [GoRouter].
  BuildContext? get context =>
      _goRouter.routerDelegate.navigatorKey.currentContext;

  GoRouter get _goRouter {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: SplashRoute().splashRoutePath,
          name: SplashRoute().splashRouteName,
          builder: SplashRoute().splashRouteBuilder,
        ),
        GoRoute(
          path: AuthRoute().authRoutePath,
          name: AuthRoute().authRouteName,
          builder: AuthRoute().authRouteBuilder,
        ),
        GoRoute(
          path: HomeRoute().homeRoutePath,
          name: HomeRoute().homeRouteName,
          builder: HomeRoute().homeRouteBuilder,
        ),
      ],
    );
  }
}
