
import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/constants.dart';
import 'intro/intro_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: AppColors.color4,
        fontFamily: Constants.poiretOne,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              bodyText2: const TextStyle(fontSize: 20, color: Colors.black),
              headline1: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: Constants.spartan,
              ),
            ),
      ),
      home: const IntroScreen(),
    );
  }
}

