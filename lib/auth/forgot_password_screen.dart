import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';
import 'package:medease/main/main_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  static const registrationNumber = "registrationNumber";
  static const studentEmail = "studentEmail";
  final _regisitrationNumberFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  final _initValues = {
    registrationNumber: '',
    studentEmail: '',
  };

  @override
  void dispose() {
    _regisitrationNumberFocusNode.dispose();
    super.dispose();
  }

  bool _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false) {
      return false;
    }
    _form.currentState?.save();
    //save here
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle2 = themeData.textTheme.bodyText2;

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
                  'Forgot Your Password',
                  style: themeData.textTheme.headline1!
                      .copyWith(fontSize: 38, color: AppColors.color3),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Enter your student email and we'll send you a link to reset your password",
                    textAlign: TextAlign.center,
                    style: textStyle2,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Student Email",
                  ),
                  style: textStyle2,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_regisitrationNumberFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your student email.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _initValues[studentEmail] = value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: "Regsitration Number ",
                  ),
                  style: textStyle2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your registration number.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _initValues[registrationNumber] = value ?? "";
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
                        textStyle: textStyle2!.copyWith(
                          color: Colors.white,
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        _saveForm();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password recovery')));
                        Navigator.of(context)
                            .push(CustomPageRoute(screen: const MainScreen()));
                      },
                      child: const Text(
                        'Submit',
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
                      child: const Text('Back to login')),
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
