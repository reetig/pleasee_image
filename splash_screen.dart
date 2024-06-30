import 'package:flutter/material.dart';
import 'package:imageappfinal/splash_screen.dart';
import 'main_screen.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MainScreen(),
      title: Text(
        'Digital innovations',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset('assets/logo.jpg'), // Add your logo in assets folder
      backgroundColor: Colors.white,
      loaderColor: Colors.blue,
    );
  }
}
