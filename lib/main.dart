import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/constants.dart';
import 'package:provider/provider.dart';

import 'intro/intro_screen.dart';
import 'listeners/menu_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuModelListener(),
        ),
      ],
      child: MaterialApp(
        title: Constants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: AppColors.color4,
          fontFamily: Constants.mulish,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                bodyText2: const TextStyle(fontSize: 19, color: Colors.black),
                headline1: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: Constants.spartan,
                ),
              ),
        ),
        home: const IntroScreen(),
        navigatorObservers: [MyApp.routeObserver],
      ),
    );
  }
}

