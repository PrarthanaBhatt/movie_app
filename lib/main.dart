import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/auth/login/login_screen.dart';

void main() {
  runApp(
    // Enabled Riverpod for the entire application

    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///RouteInformationParser- which takes the RouteInformation from RouteInformationProvider
    ///and parses it into a user-defined data type.
    ///
    ///RouterDelegate — defines app-specific behavior of how the Router learns about changes in app state
    /// and how it responds to them. Its job is to listen to the RouteInformationParser
    /// and the app state and build the Navigator with the current list of Pages.
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
