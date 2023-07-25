import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/ui/add_movie/add_movie.dart';
import 'package:movie_app/src/ui/auth/login/login_screen.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen.dart';
import 'package:movie_app/src/ui/crud_demo_sqlite/crud_demo_sqlite.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard.dart';
import 'package:movie_app/src/ui/dashboard/movie_db_dashboard.dart';
import 'package:movie_app/src/ui/dashboard_provider/dashboard_consumer_screen.dart';
import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_screen.dart';
import 'package:movie_app/src/ui/dashboard_provider/state_notifier_provider_list/state_notifier_provider_list.dart';
import 'package:movie_app/src/ui/dashboard_provider/state_provider_demo.dart';
import 'package:movie_app/src/ui/image_store_sqlite/network_image_storage_example.dart';
import 'package:movie_app/src/ui/movie_detail/movie_details.dart';

class Routes {
  const Routes._();
  static String loginScreen = "/";
  static String movieDashboard = "/movie-dashboard";
  static String registrationScreen = "/registration";
  static String movieDetails = "/movie-details";
  static String addMovie = "/add-movie";
  static String dashboardProvider = "/dashboard-provider";
  static String stateProviderDemoScreen = "/state-provider-demo-screen";
  static String stateNotifierProviderList = "/state-notifier-provider-list";
  static String dashboardConsumerScreen = "/dashboard-consumer-screen";
  static String crudDemoSqlite = "/crud-demo-sqlite";
  static String movieDBDashboardScreen = "/movie-db-dashboard-screen";
  static String networkImageStorageExample = "/network-image-storage-example";
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
    GoRoute(
      path: Routes.stateProviderDemoScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const StateProviderDemo();
      },
    ),
    GoRoute(
      path: Routes.stateNotifierProviderList,
      builder: (BuildContext context, GoRouterState state) {
        return const StateNotifierProviderList();
      },
    ),
    GoRoute(
      path: Routes.dashboardConsumerScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardConsumerScreen();
      },
    ),
    GoRoute(
      path: Routes.crudDemoSqlite,
      builder: (BuildContext context, GoRouterState state) {
        return const CrudDemoSqlite();
      },
    ),
    GoRoute(
      path: Routes.movieDBDashboardScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const MovieDBDashboardScreen();
      },
    ),
    GoRoute(
      path: Routes.networkImageStorageExample,
      builder: (BuildContext context, GoRouterState state) {
        return NetworkImageStorageExample();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('${state.error}'),
    ),
  ),
);
