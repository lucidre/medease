import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    final heading1 = textTheme.headline1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mu Profile',
          style: heading1!.copyWith(fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: const Text('Menu Clicked')));
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeaderLayout(textStyle1, textStyle2),
              const SizedBox(
                height: 15,
              ),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.all(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Basic Info',
                          style: textStyle1,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.all(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'My Documents',
                          textAlign: TextAlign.center,
                          style: textStyle1,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.all(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'My Appointments',
                          textAlign: TextAlign.center,
                          style: textStyle1,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.all(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Reviews',
                          textAlign: TextAlign.center,
                          style: textStyle1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign out clicked'),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Out',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildHeaderLayout(TextStyle? textStyle1, TextStyle? textStyle2) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: AppColors.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            child: Image.asset(
              'assets/images/onboarding_3.png',
              width: 200,
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Lorem Ipisidom Swep',
            style: textStyle1!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Lorem/2025/004',
            style: textStyle2!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
