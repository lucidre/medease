import 'package:flutter/material.dart';

import '../helper_widgets/blue_image.dart';
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
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.4,
              width: double.infinity,
              imageLocation: 'assets/images/dummy1.jpg'),
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(themeData),
                  Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 8),
                      child: buildBody(themeData)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(ThemeData themeData) {
    var textStyle1 = themeData.textTheme.bodyText1;
    var textStyle2 = themeData.textTheme.bodyText2;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Our services',
        style: textStyle1!.copyWith(fontSize: 30),
      ),
      const SizedBox(
        height: 15,
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
                borderRadius: BorderRadius.circular(8),
              ),
              color: AppColors.color4,
              elevation: 8,
              shadowColor: AppColors.color2,
              margin: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 6.0, right: 6.0, top: 15, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dummyData[index]['title'] ?? "",
                      style: textStyle1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      dummyData[index]['body'] ?? "",
                      style: textStyle2,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            );
          }),
      const SizedBox(
        height: 20,
      ),
      ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Image.asset(
          'assets/images/dummy8.jpg',
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
        ),
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
                EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 15),
            child: Text('Learn More'),
          )),
      const SizedBox(
        height: 20,
      ),
    ]);
  }

  Widget buildHeader(ThemeData themeData) {
    var heading1 = themeData.textTheme.headline1;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/full_logo.png',
                height: 40,
                color: Colors.white,
                width: 100,
                fit: BoxFit.contain,
              ),
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Virtual healthcare for you',
            style: heading1!.copyWith(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}

final dummyData = [
  {
    "title": "Book Appointment",
    'body': 'Choose your doctor from our specialist in the hospital'
  },
  {
    "title": "Online pharmacy",
    'body':
        'Get your medicines with our mobile application with a simple delivery system'
  },
  {
    "title": "Consultation",
    'body':
        'Free consultation with our trusted doctors and get the best recommendations'
  },
  {
    "title": "Tracking",
    'body': 'Track and save your medical history and health data'
  },
  {
    "title": "Emergency care",
    'body':
        'You can get 24/7 urgent care for yourself or your children and your lovely family'
  },
  {
    "title": "Details info",
    'body':
        'Free consultation with our trusted doctors and get the best recommendations'
  },
];
