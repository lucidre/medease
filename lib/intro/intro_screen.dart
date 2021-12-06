import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/onboarding/onboarding_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.color2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              minRadius: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'E',
                  style: themeData.textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45),
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'MedEase',
              style: themeData
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 38, color: AppColors.color3),
            ),
          ],
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
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const OnBoardingScreen()));
  }

  Future startTime() async {
    return Timer(const Duration(milliseconds: 6000), route);
  }
}
