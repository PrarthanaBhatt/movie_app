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
      context.go(Routes.movieDBDashboardScreen);
    } else {
      context.go(Routes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFF3E6E8),
                Color(0xFFD5D0E5),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/png/icon.png",
                  height: 400.0,
                  width: 400.0,
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Movie App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  "testt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
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
