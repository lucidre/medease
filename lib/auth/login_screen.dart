import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/auth.dart';
import 'package:medease/main/profile_screen.dart';

import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _registrationNumber = "registrationNumber";
  static const _password = "password";

  bool _isHidden = true;
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
    var textTheme = Theme.of(context).textTheme.bodyText1;

    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator.adaptive()),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Loading....',
              style: textTheme,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    showGeneralDialog(
      context: context,
      barrierLabel: "Progressbar",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    var navigatorState = Navigator.of(context);

    final registrationNumber = _initValues[_registrationNumber];
    final password = _initValues[_password];
    final String response =
        await login(registration: registrationNumber, password: password);
    switch (response) {
      case '--':
        //login successful_proceed
        navigatorState.pop();
        navigatorState.pushAndRemoveUntil(
            CustomPageRoute(screen: const ProfileScreen()), (route) => false);
        break;
      default:
        //error occurred, handle error
        navigatorState.pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));
        break;
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false) {
      return;
    }
    _form.currentState?.save();
    //login user here
    showLoginStatus();
  }

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
        child: SingleChildScrollView(
          child: Form(
            key: _form,
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
                  'MedEase',
                  style: themeData.textTheme.headline1!
                      .copyWith(fontSize: 38, color: AppColors.color3),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Welcome Back!',
                    style: textStyle1!.copyWith(color: AppColors.color3),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign in to your account',
                    style: textStyle2!.copyWith(color: Colors.lightBlue),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Registration Number",
                  ),
                  style: textStyle2,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your registration number.';
                    } /* else if (!RegExp(r"[a-zA-Z]{3}\/[0-9]{4}\/[0-9]+")
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
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: _isHidden,
                  focusNode: _passwordFocusNode,
                  enableSuggestions: !_isHidden,
                  autocorrect: !_isHidden,
                  style: textStyle2,
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
                    labelText: "Password",
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
                  height: 5,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ForgotPassword(),
                        transitionsBuilder: (_, Animation<double> animation, __,
                            Widget widget) {
                          return Opacity(
                            opacity: animation.value,
                            child: widget,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 1500),
                      ));
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
                        textStyle: textStyle2.copyWith(
                          color: Colors.white,
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        _saveForm();
                      },
                      child: const Text(
                        'Sign In',
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            screen: const RegisterScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        textStyle: Theme.of(context).textTheme.bodyText2,
                      ),
                      child: const Text('Don\'t have an account? Sign up')),
                ),
                const SizedBox(
                  height: 30,
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
    );
  }
}
