import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../main/profile_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../user_model.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      body: Center(
        child: Image.asset(
          'assets/images/full_logo.png',
          width: 250,
          color: AppColors.primary,
          height: 150,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void route() {
    var navigatorState = Navigator.of(context);
    if (UserPref.onBoardingStatus) {
      if (UserPref.isUserLoggedIn) {
        navigatorState
            .pushReplacement(CustomPageRoute(screen: const ProfileScreen()));
      } else {
        navigatorState
            .pushReplacement(CustomPageRoute(screen: const LoginScreen()));
      }
    } else {
      navigatorState
          .pushReplacement(CustomPageRoute(screen: const OnBoardingScreen()));
    }
  }

  Future startTime() async {
    return Timer(const Duration(milliseconds: 6000), route);
  }
}
