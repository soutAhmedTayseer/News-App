import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'NewsLayout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'Montserrat',
      ),
      child: AnimatedSplashScreen(
        splash: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/images/news.json',
                  animate: true,
                  repeat: false,
                  reverse: false,
                ),
              ),
            ),
          ],
        ),
        nextScreen: const NewsLayout(),
        splashIconSize: 350,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
