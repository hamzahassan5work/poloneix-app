// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:poloniex_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:poloniex_app/features/bootup/splash_screen.dart';
import 'package:poloniex_app/features/trade/presentation/screens/trade_screen.dart';

/// An abstract interface class representing a route.
abstract interface class _Route {
  final String path;
  final String name;
  final Widget Function(BuildContext context, GoRouterState state) builder;

  _Route(this.path, this.name, this.builder);
}

/// A class representing an splash route.
class SplashRoute implements _Route {
  @override
  final Widget Function(BuildContext context, GoRouterState state) builder =
      (context, state) => const SplashScreen();

  @override
  final String name = 'splash';

  @override
  final String path = '/';

  /// Returns the path of the splash route.
  String get splashRoutePath => path;

  /// Returns the name of the splash route.
  String get splashRouteName => name;

  /// Returns the builder function for the splash route.
  Widget Function(BuildContext context, GoRouterState state)
      get splashRouteBuilder => builder;
}

/// A class representing an authentication route.
class AuthRoute implements _Route {
  @override
  final Widget Function(BuildContext context, GoRouterState state) builder =
      (context, state) => const AuthScreen();

  @override
  final String name = 'auth';

  @override
  final String path = '/auth';

  /// Returns the path of the authentication route.
  String get authRoutePath => path;

  /// Returns the name of the authentication route.
  String get authRouteName => name;

  /// Returns the builder function for the authentication route.
  Widget Function(BuildContext context, GoRouterState state)
      get authRouteBuilder => builder;
}

/// A class representing a home route.
class HomeRoute implements _Route {
  @override
  final Widget Function(BuildContext context, GoRouterState state) builder =
      (context, state) => const TradeScreen();

  @override
  final String name = 'home';

  @override
  final String path = '/home';

  /// Returns the path of the home route.
  String get homeRoutePath => path;

  /// Returns the name of the home route.
  String get homeRouteName => name;

  /// Returns the builder function for the home route.
  Widget Function(BuildContext context, GoRouterState state)
      get homeRouteBuilder => builder;
}
