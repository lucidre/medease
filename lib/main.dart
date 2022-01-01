import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper_widgets/constants.dart';
import 'intro/intro_screen.dart';
import 'listeners/menu_model.dart';
import 'user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPref.init();
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
          canvasColor: Colors.white,
          // canvasColor: AppColors.color4,
          fontFamily: Constants.mulish,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                bodyText2: const TextStyle(fontSize: 18, color: Colors.black),
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
