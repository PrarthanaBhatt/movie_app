import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/constants/sharedpref_value.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () =>
          // context.go("/"),
          checkNextRoute(),
    );
    super.initState();
  }

  Future<void> checkNextRoute() async {
    final getLoggedIn = await SharedPrefValue.getPrefValue(isLoggedIn, bool);

    if (getLoggedIn != null && getLoggedIn) {
      context.go(Routes.loginScreen);

      // context.go(Routes.movieDBDashboardScreen);

      //INFO: When to load the API response from provider use below
      // context.go(Routes.dashboardProvider);
    } else {
      context.go(Routes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/png/play_icon.jpg",
                  height: 400.0,
                  width: 400.0,
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "CineWorld",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Your Personal Movie Guide",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
