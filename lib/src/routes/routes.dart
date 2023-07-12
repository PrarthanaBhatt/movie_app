import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/ui/auth/login/login_screen.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard.dart';

class Routes {
  const Routes._();
  static String loginScreen = "/";
  static String movieDashboard = "/movie-dashboard";
  static String registrationScreen = "/registration";
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.loginScreen,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.loginScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.movieDashboard,
      builder: (BuildContext context, GoRouterState state) {
        return const MovieDashboard();
      },
    ),
    GoRoute(
      path: Routes.registrationScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const RegistrationScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('${state.error}'),
    ),
  ),
);
