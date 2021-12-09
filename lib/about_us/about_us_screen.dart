import 'package:flutter/material.dart';

import '../helper_widgets/colors.dart';
import '../main/drawer_screen.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(themeData),
            buildBody(themeData),
          ],
        ),
      ),
    );
  }

  Padding buildBody(ThemeData themeData) {
    var textStyle1 = themeData.textTheme.bodyText1;
    var textStyle2 = themeData.textTheme.bodyText2;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          'assets/images/onboarding_3.png',
          width: double.infinity,
          height: 250,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Our services',
          style: textStyle1,
        ),
        const SizedBox(
          height: 8,
        ),
        GridView.builder(
            itemCount: 6,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (ctx, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColors.color4,
                elevation: 8,
                shadowColor: AppColors.color2,
                margin: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data',
                        style: textStyle1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: Text(
                          'We can safely say that the disciples have been with Jesus long enough to know that what he says comes true but the man on the other end may have just been a regular person praying to be used by God or has been shown a sign. another example would be the donkey used by Jesus, though their names where not recorded they aligned with the scriptures by allowing the savior to use what they had. ',
                          style: textStyle2,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/onboarding_2.png',
          width: double.infinity,
          height: 250,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Leading Healthcare Providers',
              style: textStyle1,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              'We can safely say that the disciples have been with Jesus long enough to know that what he says comes true but the man on the other end may have just been a regular person praying to be used by God or has been shown a sign. another example would be the donkey used by Jesus, though their names where not recorded they aligned with the scriptures by allowing the savior to use what they had. ',
              style: textStyle2,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Learn More')));
            },
            style: OutlinedButton.styleFrom(
              primary: Colors.blue,
              side: const BorderSide(color: Colors.blue, width: 2),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.blue),
            ),
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
              child: Text('Learn More'),
            )),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  Container buildHeader(ThemeData themeData) {
    var heading1 = themeData.textTheme.headline1;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.color2,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'E',
                    style: heading1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Virtual healthcare for you',
            style: heading1.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 90,
          ),
        ]),
      ),
    );
  }
}
