import 'package:flutter/material.dart';
import 'package:medease/library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:medease/library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';

import '../auth/pick_signin_or_signup.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _fontHeaderStyle = const TextStyle(
      fontFamily: Constants.spartan,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      letterSpacing: 1.5);
  final _fontDescriptionStyle = const TextStyle(
      fontFamily: Constants.spartan,
      fontSize: 18.0,
      color: Colors.black26,
      fontWeight: FontWeight.w400);
  List<PageViewModel> pages = [];

  @override
  void initState() {
    pages = [
      PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            'Virtual Health Care For You',
            style: _fontHeaderStyle,
          ),
          body: SizedBox(
            height: 250.0,
            child: Text(
                'Seed Market Hub is a multi-vendor ecommerce application that is dedicated for seeds',
                textAlign: TextAlign.center,
                style: _fontDescriptionStyle),
          ),
          mainImage: Image.asset(
            'assets/images/onboarding_1.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            'Quick Emergency Response',
            style: _fontHeaderStyle,
          ),
          body: SizedBox(
            height: 250.0,
            child: Text(
                'Seed Market Hub is a multi-vendor ecommerce application that is dedicated for seeds',
                textAlign: TextAlign.center,
                style: _fontDescriptionStyle),
          ),
          mainImage: Image.asset(
            'assets/images/onboarding_2.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            'Documentation Made Easy',
            style: _fontHeaderStyle,
          ),
          body: SizedBox(
            height: 250.0,
            child: Text(
                'Seed Market Hub is a multi-vendor ecommerce application that is dedicated for seeds',
                textAlign: TextAlign.center,
                style: _fontDescriptionStyle),
          ),
          mainImage: Image.asset(
            'assets/images/onboarding_3.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: AppColors.color6,
      skipText: Text(
        "SKIP",
        style: _fontDescriptionStyle.copyWith(
            color: AppColors.color3,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: _fontDescriptionStyle.copyWith(
            color: AppColors.color3,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PickSignInOrLoginScreen(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget widget) {
            return Opacity(
              opacity: animation.value,
              child: widget,
            );
          },
          transitionDuration: const Duration(milliseconds: 1500),
        ));
      },
    );
  }
}
