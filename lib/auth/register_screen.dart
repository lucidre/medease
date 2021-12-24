import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/auth.dart';
import 'package:medease/helper_widgets/blue_image.dart';
import 'package:medease/helper_widgets/page_route.dart';

import '../helper_widgets/colors.dart';
import 'verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _emailAccount = "emailAccount";
  static const _firstName = "firstName";
  static const _lastName = "lastName";
  static const _password = "password";
  final passwordTextEditingController = TextEditingController(text: "");
  final retypePasswordTextEditingController = TextEditingController(text: "");
  bool _isPasswordHidden = true;
  bool _isLoading = false;
  bool _isRetypePasswordHidden = true;
  final _emailNumberFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _retypePasswordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _initValues = {
    _firstName: '',
    _lastName: '',
    _emailAccount: '',
    _password: '',
  };
  var password = "";
  var retypePassword = "";

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
    _lastNameFocusNode.dispose();
    _emailNumberFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false || _isLoading) {
      return;
    }
    _form.currentState?.save();
    showRegistrationStatus();
  }

  Future showRegistrationStatus() async {
    var navigatorState = Navigator.of(context);
    final registrationNumber = _initValues[_emailAccount];
    final password = _initValues[_password];
    final firstName = _initValues[_firstName];
    final lastName = _initValues[_lastName];

    setState(() {
      _isLoading = true;
    });

    final String response = await signUp(
        firstName: firstName,
        lastName: lastName,
        registrationNumber: registrationNumber,
        password: password);

    setState(() {
      _isLoading = false;
    });

    switch (response) {
      case '--':
        //login successful_proceed
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')));
        navigatorState.push(
          CustomPageRoute(
            screen: const VerificationScreen(),
          ),
        );
        break;
      default:
        //error occurred, handle error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));
        break;
    }
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
                      'Welcome to MedEase!',
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
                      'Create a new account',
                      style: textStyle2!.copyWith(color: Colors.lightBlue),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'First Name',
                      style: textStyle2.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Enter your full name",
                    ),
                    style: textStyle2.copyWith(fontSize: 18),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_lastNameFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your first name.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _initValues[_firstName] = value ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Last Name',
                      style: textStyle2.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    focusNode: _lastNameFocusNode,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Please provide your last name",
                    ),
                    style: textStyle2.copyWith(fontSize: 18),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_emailNumberFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your last name.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _initValues[_lastName] = value ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Registration Number',
                      style: textStyle2.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    focusNode: _emailNumberFocusNode,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "(Student’s Matric Number/UTME Number)",
                    ),
                    style: textStyle2.copyWith(fontSize: 18),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your registration number.';
                      }
                      /* else if (!RegExp(r"[a-zA-Z]{3}/[0-9]{4}/[0-9]+$")
                          .hasMatch(value)) {
                        return "Please provide a valid registration number";
                      }*/
                      return null;
                    },
                    onSaved: (value) {
                      _initValues[_emailAccount] = value ?? "";
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
                    onSaved: (value) {
                      _initValues[_password] = value ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Retype Password',
                      style: textStyle2.copyWith(fontWeight: FontWeight.bold),
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
                            _isRetypePasswordHidden = !_isRetypePasswordHidden;
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
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Register',
                                  style: textStyle2.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account?',
                        style: textStyle2.copyWith(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Sign in',
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
                          const SnackBar(content: Text('Terms clicked')));
                    },
                    child: const Text(
                      'Terms of use. Privacy policy',
                    ),
                    style: TextButton.styleFrom(
                      textStyle: textStyle2.copyWith(fontSize: 18),
                    ),
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
