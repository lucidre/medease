import 'package:flutter/material.dart';

import '../../helper_widgets/blue_image.dart';
import '../../helper_widgets/colors.dart';
import '../../helper_widgets/page_route.dart';
import '../register_screen.dart';
import 'reset_password_screen3.dart';

class ResetPassword2Screen extends StatefulWidget {
  const ResetPassword2Screen({Key? key}) : super(key: key);

  @override
  State<ResetPassword2Screen> createState() => _ResetPassword2ScreenState();
}

class _ResetPassword2ScreenState extends State<ResetPassword2Screen> {
  String _verificationCode = '';
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false || _isLoading) {
      return;
    }
    _form.currentState?.save();

    Navigator.of(context)
        .push(CustomPageRoute(screen: const ResetPassword3Screen()));
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
              imageLocation: 'assets/images/dummy4.jpg'),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                              style: textStyle1!.copyWith(
                                  color: AppColors.color3, fontSize: 30),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Check your student email and enter the verification code sent to you",
                              style:
                                  textStyle2!.copyWith(color: Colors.lightBlue),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Verification Code',
                              style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: "Enter the code",
                            ),
                            style: textStyle2.copyWith(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide the code sent.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _verificationCode = value ?? "";
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                elevation: 5,
                              ),
                              onPressed: () {
                                _saveForm();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'Verify Code',
                                        style: textStyle2.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: textStyle2.copyWith(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          CustomPageRoute(
                            screen: const RegisterScreen(),
                          ),
                          (route) => route.isFirst);
                    },
                    child: const Text(
                      'Sign up',
                    ),
                    style: TextButton.styleFrom(
                        textStyle: textStyle2.copyWith(fontSize: 18)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
