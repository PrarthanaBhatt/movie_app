import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/ui/add_movie/add_movie.dart';
import 'package:movie_app/src/ui/auth/login/login_screen.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard.dart';
import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_screen.dart';
import 'package:movie_app/src/ui/movie_detail/movie_details.dart';

class Routes {
  const Routes._();
  static String loginScreen = "/";
  static String movieDashboard = "/movie-dashboard";
  static String registrationScreen = "/registration";
  static String movieDetails = "/movie-details";
  static String addMovie = "/add-movie";
  static String dashboardProvider = "/dashboard-provider";
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.dashboardProvider,
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
      path:
          "/movie-details/:overview/:releaseDate/:backdropPath/:originalLanguage/:originalTitle",
      builder: (BuildContext context, GoRouterState state) {
        return MovieDetails(
          overview: state.pathParameters['overview'] ?? "",
          backdropPath: state.pathParameters['backdropPath'] ?? "",
          releaseDate: state.pathParameters['releaseDate'] ?? "",
          originalLanguage: state.pathParameters['originalLanguage'] ?? "",
          originalTitle: state.pathParameters['originalTitle'] ?? "",
        );
      },
    ),
    GoRoute(
      path: Routes.addMovie,
      builder: (BuildContext context, GoRouterState state) {
        return const AddMovie();
      },
    ),
    GoRoute(
      path: Routes.dashboardProvider,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardProvider();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('${state.error}'),
    ),
  ),
);
