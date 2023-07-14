import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/ui/auth/login/login_screen.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard.dart';
import 'package:movie_app/src/ui/movie_detail/movie_details.dart';

class Routes {
  const Routes._();
  static String loginScreen = "/";
  static String movieDashboard = "/movie-dashboard";
  static String registrationScreen = "/registration";
  static String movieDetails = "/movie-details";
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.loginScreen,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.registrationScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const RegistrationScreen();
      },
    ),
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
      name: Routes.movieDetails,
      path: "/movie-details/:original_title/:overview",
      builder: (BuildContext context, GoRouterState state) {
        return MovieDetails(
          originalTitle: state.pathParameters['original_title'] ?? "",
          overview: state.pathParameters['overview'] ?? "",
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('${state.error}'),
    ),
  ),
);
