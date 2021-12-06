import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';
import 'package:medease/main/main_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String verificationCode = "";

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle2 = themeData.textTheme.bodyText2;
    var textStyle1 = themeData.textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(
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
              'Enter Verification Code',
              textAlign: TextAlign.center,
              style: themeData.textTheme.headline1!
                  .copyWith(fontSize: 38, color: AppColors.color3),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Check your student email and enter the verification code sent to you.",
              textAlign: TextAlign.center,
              style: textStyle2,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Verification Code',
              textAlign: TextAlign.center,
              style: textStyle1,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                width: 3,
                color: Colors.black54,
              ))),
              style: textStyle2,
              onSubmitted: (code) {
                verificationCode = code;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: textStyle2!.copyWith(
                      color: Colors.white,
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Done pressed')));
                    Navigator.of(context)
                        .push(CustomPageRoute(screen: const MainScreen()));
                  },
                  child: const Text(
                    'Done',
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('terms clicked')));
              },
              child: const Text(
                'Terms of use. Privacy policy',
              ),
              style: TextButton.styleFrom(textStyle: textStyle2),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
