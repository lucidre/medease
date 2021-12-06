import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';

class UserBasicInfoScreen extends StatelessWidget {
  const UserBasicInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    final heading1 = textTheme.headline1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Basic Info',
                        style: textStyle1!.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton.icon(
                        label: Text(
                          'Edit Profile',
                          style: textStyle2!.copyWith(color: Colors.white),
                        ),
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
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
                    height: 20,
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Text(
                    'Basic Information',
                    style: heading1!.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      Text(
                        'Gender:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Male',
                        style: textStyle2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        'Date of birth:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '06/08/2021',
                        style: textStyle2,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Text(
                    'Contact Information',
                    style: heading1.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      Text(
                        'Address:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Awo Hall, Obafemi Awolowo University, Ile-Ife ',
                        style: textStyle2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        'Phone number:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '+2347089671941',
                        style: textStyle2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        'Email address:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'swepgroup9@oauife.edu.ng',
                        style: textStyle2,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Text(
                    'Health Information',
                    style: heading1!.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      Text(
                        'Blood type:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'AB',
                        style: textStyle2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        'Genotype:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'AS',
                        style: textStyle2,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Text(
                    'Settings',
                    style: heading1.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        'Location:',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Switch.adaptive(value: true, onChanged: (value) {})
                    ],
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}
