import 'package:flutter/material.dart';

import '../../helper_widgets/blue_image.dart';
import '../../helper_widgets/colors.dart';
import '../../helper_widgets/page_route.dart';
import '../register_screen.dart';

class ResetPassword3Screen extends StatefulWidget {
  const ResetPassword3Screen({Key? key}) : super(key: key);

  @override
  State<ResetPassword3Screen> createState() => _ResetPassword3ScreenState();
}

class _ResetPassword3ScreenState extends State<ResetPassword3Screen> {
  String _verificationCode = '';
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  var password = "";
  var retypePassword = "";
  final passwordTextEditingController = TextEditingController(text: "");
  final retypePasswordTextEditingController = TextEditingController(text: "");
  bool _isPasswordHidden = true;
  bool _isRetypePasswordHidden = true;
  final _passwordFocusNode = FocusNode();
  final _retypePasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordTextEditingController.addListener(() {
      password = passwordTextEditingController.text;
    });
    retypePasswordTextEditingController.addListener(() {
      retypePassword = retypePasswordTextEditingController.text;
    });
  }

  @override
  void dispose() {
    passwordTextEditingController.dispose();
    retypePasswordTextEditingController.dispose();
    _passwordFocusNode.dispose();
    _retypePasswordFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false || _isLoading) {
      return;
    }
    _form.currentState?.save();
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
                              'Reset Your Password',
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
                              "Your new password must be different from previous password",
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
                              'Password',
                              style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            obscureText: _isPasswordHidden,
                            controller: passwordTextEditingController,
                            focusNode: _passwordFocusNode,
                            enableSuggestions: !_isPasswordHidden,
                            autocorrect: !_isPasswordHidden,
                            style: textStyle2.copyWith(fontSize: 18),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordHidden = !_isPasswordHidden;
                                  });
                                },
                              ),
                              hintText: "Set a secure and strong password",
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide  your password';
                              } else if (value != retypePassword) {
                                return 'Passwords are not the same';
                              } else if (value.length < 6) {
                                return 'Password must be more than 6 letters';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_retypePasswordFocusNode);
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Retype Password',
                              style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: retypePasswordTextEditingController,
                            obscureText: _isRetypePasswordHidden,
                            focusNode: _retypePasswordFocusNode,
                            enableSuggestions: !_isRetypePasswordHidden,
                            autocorrect: !_isRetypePasswordHidden,
                            style: textStyle2.copyWith(fontSize: 18),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isRetypePasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isRetypePasswordHidden =
                                        !_isRetypePasswordHidden;
                                  });
                                },
                              ),
                              hintText: "Please enter your password again",
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide  your password';
                              } else if (value != password) {
                                return 'Passwords are not the same';
                              } else if (value.length < 6) {
                                return 'Password must be more than 6 letters';
                              }
                              return null;
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
