import 'package:flutter/material.dart';
import 'package:medease/auth/verification_screen.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _registrationNumber = "registrationNumber";
  static const _fullName = "fullName";
  static const _password = "password";
  final passwordTextEditingController = TextEditingController(text: "");
  final retypePasswordTextEditingController = TextEditingController(text: "");
  bool _isPasswordHidden = true;
  bool _isRetypePasswordHidden = true;
  final _registrationNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _retypePasswordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _initValues = {
    _fullName: '',
    _registrationNumber: '',
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
    _registrationNumberFocusNode.dispose();
    super.dispose();
  }

     _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false) {
      return ;
    }
    _form.currentState?.save();
    Navigator.of(context).push(
      CustomPageRoute(
        screen: const VerificationScreen(),
      ),
    );
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
                    'Welcome!',
                    style: textStyle1!.copyWith(color: AppColors.color3),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Create a new account',
                    style: textStyle2!.copyWith(color: Colors.lightBlue),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                  ),
                  style: textStyle2,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_registrationNumberFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your full name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _initValues[_fullName] = value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: _registrationNumberFocusNode,
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
                  textInputAction: TextInputAction.next,
                  obscureText: _isPasswordHidden,
                  controller: passwordTextEditingController,
                  focusNode: _passwordFocusNode,
                  enableSuggestions: !_isPasswordHidden,
                  autocorrect: !_isPasswordHidden,
                  style: textStyle2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
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
                    else if (value != retypePassword) {
                      return 'Passwords are not the same';
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
                  height: 5,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: retypePasswordTextEditingController,
                  obscureText: _isRetypePasswordHidden,
                  focusNode: _retypePasswordFocusNode,
                  enableSuggestions: !_isRetypePasswordHidden,
                  autocorrect: !_isRetypePasswordHidden,
                  style: textStyle2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isRetypePasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isRetypePasswordHidden = !_isRetypePasswordHidden;
                        });
                      },
                    ),
                    labelText: "Retype Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide  your password';
                    } else if (value != password) {
                      return 'Passwords are not the same';
                    }
                    return null;
                  },
                  onSaved: (value) {
               //
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
                        elevation: 3,
                      ),
                      onPressed: () {
                        _saveForm();
                      },
                      child: const Text(
                        'Register',
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        textStyle: Theme.of(context).textTheme.bodyText2,
                      ),
                      child: const Text('Already have an account? sign in')),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    //
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