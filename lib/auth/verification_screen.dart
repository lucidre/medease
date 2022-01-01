import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/blue_image.dart';
import 'package:medease/helper_widgets/page_route.dart';

import '../helper_widgets/colors.dart';
import 'login_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String verificationCode = "";
  final _form = GlobalKey<FormState>();

  bool _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false) {
      return false;
    }
    _form.currentState?.save();
    var navigatorState = Navigator.of(context);
    navigatorState.pushAndRemoveUntil(
        CustomPageRoute(screen: const LoginScreen()), (route) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    var textStyle2 = themeData.textTheme.bodyText2;
    var textStyle1 = themeData.textTheme.bodyText1;

    return Scaffold(
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.4,
              width: double.infinity,
              showHeader: true,
              headerTopSpacer: height * 0.15,
              imageLocation: 'assets/images/dummy5.jpg'),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              margin: EdgeInsets.only(top: height * 0.30),
              padding: const EdgeInsets.only(
                  top: 25.0, left: 15, right: 15, bottom: 10),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Enter Verification Code',
                        style: textStyle1!
                            .copyWith(color: AppColors.color3, fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Check your student email and enter the verification code sent to you.",
                        style: textStyle2!.copyWith(color: Colors.lightBlue),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Verification Code',
                        style: textStyle2.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: "Please enter the verification code sent",
                      ),
                      style: textStyle2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide the code sent.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        verificationCode = value ?? "";
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: textStyle2.copyWith(
                            color: Colors.white,
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          _saveForm();
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            'Verify',
                            style: textStyle2.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
            ),
          ),
        ],
      ),
    );
  }
}
