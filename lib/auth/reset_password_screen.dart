import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String newPassword = "";
  final _retypePasswordFocusNode = FocusNode();
  bool _isPasswordHidden = true;
  bool _isRetypePasswordHidden = true;
  final _form = GlobalKey<FormState>();
  var password = "";
  var retypePassword = "";
  final passwordTextEditingController = TextEditingController(text: "");
  final retypePasswordTextEditingController = TextEditingController(text: "");

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
    _retypePasswordFocusNode.dispose();
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
                  obscureText: _isPasswordHidden,
                  controller: passwordTextEditingController,
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
                    newPassword= value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
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
                        textStyle: textStyle2!.copyWith(
                          color: Colors.white,
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        _saveForm();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text('Password reset')));
                      },
                      child: const Text(
                        'Done',
                      )),
                ),
                const SizedBox(
                  height: 40,
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
