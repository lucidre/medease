import 'package:flutter/material.dart';
import 'package:medease/library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:medease/library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';

import '../auth/login_screen.dart';
import '../helper_widgets/blue_image.dart';
import '../helper_widgets/constants.dart';
import '../helper_widgets/page_route.dart';
import '../user_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _fontHeaderStyle = const TextStyle(
      fontFamily: Constants.spartan,
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5);
  final _fontDescriptionStyle = TextStyle(
      fontFamily: Constants.mulish,
      color: Colors.black.withOpacity(0.7),
      fontSize: 18.0,
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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'This can be related to opening one\'s house for house fellowship.We can safely say that the disciples have been with Jesus long enough to know that what he says comes true but the man on the other end may have just been a regular person praying to be used by God or has been shown a sign. another example would be the donkey used by Jesus',
            softWrap: true,
            overflow: TextOverflow.fade,
            style: _fontDescriptionStyle,
          ),
        ),
        mainImage: const BlueImageContainer(
          imageLocation: 'assets/images/dummy1.jpg',
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      PageViewModel(
        pageColor: Colors.white,
        iconColor: Colors.black,
        bubbleBackgroundColor: Colors.black,
        title: Text(
          'Quick Emergency Response',
          style: _fontHeaderStyle,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Peter is know as the troublesome one, the one with  the SANGUINE personality he had great plans for the lord and high trust in his love for Christ that he removed the possibility of him ever leaving Jesus.This proves the bible in Jeremiah 17:9 and Proverbs 21:2 that even men do not know their own hearts.We should not be over confident in our walk with Christ, always remaining humble. ',
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.fade,
            style: _fontDescriptionStyle,
          ),
        ),
        mainImage: const BlueImageContainer(
          imageLocation: 'assets/images/dummy2.jpg',
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      PageViewModel(
        pageColor: Colors.white,
        iconColor: Colors.black,
        bubbleBackgroundColor: Colors.black,
        title: Text(
          'Documentation Made Easy',
          style: _fontHeaderStyle,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Thinkest thou that I cannot now pray to my Father, and he shall presently give me more than twelve legions of angels? But how then shall the scriptures be fulfilled, that thus it must be? Matthew 26:5-54 KJVJesus knew who he was he knew his authority but for our sake he allowed them to take him.',
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.fade,
            style: _fontDescriptionStyle,
          ),
        ),
        mainImage: const BlueImageContainer(
          imageLocation: 'assets/images/dummy3.jpg',
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      skipText: Text(
        "SKIP",
        style: _fontDescriptionStyle.copyWith(
            fontWeight: FontWeight.w800, letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: _fontDescriptionStyle.copyWith(
            fontWeight: FontWeight.w800, letterSpacing: 1.0),
      ),
      onTapDoneButton: () async {
        UserPref.setOnBoardingStatus(status: true);
        Navigator.of(context).pushReplacement(CustomPageRoute(
          screen: const LoginScreen(),
        ));
      },
    );
  }
}
