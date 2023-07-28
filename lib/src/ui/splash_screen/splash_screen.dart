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
      backgroundColor: Color(0xFF28282B),
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
                  "assets/png/movie_icon.png",
                  height: 250.0,
                  width: 250.0,
                ),
                const SizedBox(
                  height: 80,
                ),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.56,
                    //   height: MediaQuery.of(context).size.height * 0.12,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //           color: const Color(0xFFF1F1F1), width: 1),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(20))),
                    // ),
                    Column(
                      children: const [
                        Text(
                          "CineWorld",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Your Personal Movie Guide",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff808080)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    //draw arc
    canvas.drawArc(
        Offset(50, 50) & Size(50, 50),
        0, //radians
        2, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
