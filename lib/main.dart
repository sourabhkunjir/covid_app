import 'package:covid19_app/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Covid19App());
}


class Covid19App extends StatelessWidget {
  const Covid19App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid-19 App",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue, 
      ),
      home: SplashScreen(),
    );
  }
}
