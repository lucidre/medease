import 'package:flutter/material.dart';

import '../auth/pick_signin_or_signup.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/constants.dart';
import '../helper_widgets/page_route.dart';
import '../library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import '../library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';

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
      letterSpacing: 1.5);
  final _fontDescriptionStyle = const TextStyle(
      fontFamily: Constants.mulish,
      fontSize: 18.0,
      fontWeight: FontWeight.w400);
  List<PageViewModel> pages = [];
  final List<Color> colors = [Colors.black, Colors.white, Colors.black];
  int currentPosition = 0;

  @override
  void initState() {
    pages = [
      PageViewModel(
          pageColor: Colors.white,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            'Virtual Health Care For You',
            style: _fontHeaderStyle.copyWith(color: colors[0]),
          ),
          body: SizedBox(
            height: 250.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'This can be related to opening one\'s house for house fellowship.We can safely say that the disciples have been with Jesus long enough to know that what he says comes true but the man on the other end may have just been a regular person praying to be used by God or has been shown a sign. another example would be the donkey used by Jesus',
                softWrap: true,
                overflow: TextOverflow.fade,
                style: _fontDescriptionStyle.copyWith(
                    color: colors[0].withOpacity(0.7)),
              ),
            ),
          ),
          mainImage: Image.asset(
            'assets/images/onboarding_1.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
          pageColor: AppColors.primary,
          iconColor: Colors.black,
          bubbleBackgroundColor: Colors.black,
          title: Text(
            'Quick Emergency Response',
            style: _fontHeaderStyle.copyWith(color: colors[1]),
          ),
          body: SizedBox(
            height: 250.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Peter is know as the troublesome one, the one with  the SANGUINE personality he had great plans for the lord and high trust in his love for Christ that he removed the possibility of him ever leaving Jesus.This proves the bible in Jeremiah 17:9 and Proverbs 21:2 that even men do not know their own hearts.We should not be over confident in our walk with Christ, always remaining humble. ',
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: _fontDescriptionStyle.copyWith(
                    color: colors[1].withOpacity(0.7)),
              ),
            ),
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
            style: _fontHeaderStyle.copyWith(color: colors[2]),
          ),
          body: SizedBox(
            height: 250.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Thinkest thou that I cannot now pray to my Father, and he shall presently give me more than twelve legions of angels? But how then shall the scriptures be fulfilled, that thus it must be? Matthew 26:5-54 KJVJesus knew who he was he knew his authority but for our sake he allowed them to take him.',
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: _fontDescriptionStyle.copyWith(
                    color: colors[2].withOpacity(0.7)),
              ),
            ),
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
      onPageSwiped: (position) {
        setState(() {
          currentPosition = position;
        });
      },
      skipText: Text(
        "SKIP",
        style: _fontDescriptionStyle.copyWith(
            color: colors[currentPosition],
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: _fontDescriptionStyle.copyWith(
            color: colors[currentPosition],
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () async {
        Navigator.of(context).pushReplacement(CustomPageRoute(
          screen: const PickSignInOrLoginScreen(),
        ));
      },
    );
  }
}
