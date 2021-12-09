import 'package:flutter/material.dart';
import 'package:medease/about_us/about_us_screen.dart';
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
  static const _saveUser = 'saveUser';

  bool _isHidden = true;
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _initValues = {
    _registrationNumber: '',
    _password: '',
    _saveUser: false
  };

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false) {
      return false;
    }

    _form.currentState?.save();
    var navigatorState = Navigator.of(context);
    navigatorState.pushAndRemoveUntil(
        CustomPageRoute(screen: const ProfileScreen()), (route) => false);
    return true;
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
                    }
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            'Remember User?',
                            style: textStyle2.copyWith(color: Colors.black),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _initValues[_saveUser] as bool,
                          onChanged: (newValue) {
                            setState(() {
                              _initValues[_saveUser] = newValue ?? false;
                            });
                          },
                          activeColor: Colors.blue,
                          checkColor: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const ForgotPassword(),
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget widget) {
                              return Opacity(
                                opacity: animation.value,
                                child: widget,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 1500),
                          ));
                        },
                        child: const Text(
                          'Forgot Password?',
                        ),
                        style: TextButton.styleFrom(
                          textStyle:
                              textStyle2.copyWith(color: Colors.lightBlue),
                        ),
                      ),
                    ]),
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
