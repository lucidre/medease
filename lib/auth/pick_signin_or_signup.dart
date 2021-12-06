import 'package:flutter/material.dart';
import 'package:medease/auth/login_screen.dart';
import 'package:medease/auth/register_screen.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';

class PickSignInOrLoginScreen extends StatelessWidget {
  const PickSignInOrLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                minRadius: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'E',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
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
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 38, color: AppColors.color3),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Colors.white,
                              ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          screen: const LoginScreen(),
                        ),
                      );
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
                    child: const Text('Create an Account')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
