import 'package:flutter/material.dart';

import '../helper_widgets/auth.dart';
import '../helper_widgets/blue_image.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../main/profile_screen.dart';
import 'register_screen.dart';
import 'reset_password/reset_password_screen1r_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _registrationNumber = "registrationNumber";
  static const _password = "password";
  bool _isHidden = true;
  bool _isLoading = false;

  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _initValues = {
    _registrationNumber: '',
    _password: ''
  };

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }

  Future showLoginStatus() async {
    var navigatorState = Navigator.of(context);
    final registrationNumber = _initValues[_registrationNumber];
    final password = _initValues[_password];

    setState(() {
      _isLoading = true;
    });

    final String response =
        await login(registration: registrationNumber, password: password);
    setState(() {
      _isLoading = false;
    });

    switch (response) {
      case '--':
        //login successful_proceed
        navigatorState.pushAndRemoveUntil(
            CustomPageRoute(screen: const ProfileScreen()), (route) => false);
        break;
      default:
        //error occurred, handle error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));
        break;
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false || _isLoading) {
      return;
    }
    _form.currentState?.save();
    //login user here
    showLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    var textStyle2 = themeData.textTheme.bodyText2;
    var textStyle1 = themeData.textTheme.bodyText1;
    return Scaffold(
      body: Stack(children: [
        BlueImageContainer(
            height: height * 0.4,
            width: double.infinity,
            showHeader: true,
            headerTopSpacer: height * 0.15,
            imageLocation: 'assets/images/dummy4.jpg'),
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
                      'Welcome Back!',
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
                      'Sign in to your account',
                      style: textStyle2!.copyWith(color: Colors.lightBlue),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Registration Number',
                      style: textStyle2.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "(Student’s Matric Number/ UTME Number)",
                    ),
                    style: textStyle2.copyWith(fontSize: 18),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your registration number.';
                      }
                      /* else if (!RegExp(r"[a-zA-Z]{3}\/[0-9]{4}\/[0-9]+")
                          .hasMatch(value)) {
                        return "Please provide a valid registration number";
                      }*/
                      return null;
                    },
                    onSaved: (value) {
                      _initValues[_registrationNumber] = value ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Password',
                      style: textStyle2.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: _isHidden,
                    focusNode: _passwordFocusNode,
                    enableSuggestions: !_isHidden,
                    autocorrect: !_isHidden,
                    style: textStyle2.copyWith(fontSize: 18),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                      ),
                      hintText: "Enter your password.",
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide  your password';
                      } else if (value.length < 6) {
                        return 'Password must be more than 6 letters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _initValues[_password] = value ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            screen: const ResetPassword1Screen()));
                      },
                      child: const Text(
                        'Forgot Password?',
                      ),
                      style: TextButton.styleFrom(
                        textStyle: textStyle2.copyWith(color: Colors.lightBlue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : Text(
                                'Sign In',
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: textStyle2.copyWith(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                              screen: const RegisterScreen(),
                            ),
                          );
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
                    height: 45,
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('terms clicked')));
                    },
                    child: const Text(
                      'Terms of use. Privacy policy',
                    ),
                    style: TextButton.styleFrom(
                        textStyle: textStyle2.copyWith(fontSize: 18)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
