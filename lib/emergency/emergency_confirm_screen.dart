import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/blue_image.dart';
import 'package:medease/main/drawer_screen.dart';

import '../helper_widgets/colors.dart';

class EmergencyConfirmScreen extends StatefulWidget {
  const EmergencyConfirmScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyConfirmScreen> createState() => _EmergencyConfirmScreenState();
}

class _EmergencyConfirmScreenState extends State<EmergencyConfirmScreen> {
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
          Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/full_logo.png',
              height: 40,
              color: Colors.white,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Icon(
            Icons.health_and_safety,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Emergency?',
            style: heading1!.copyWith(color: Colors.white, fontSize: 35),
          ),
          const SizedBox(
            height: 25,
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle1 = themeData.textTheme.bodyText1;
    var height = MediaQuery.of(context).size.height;
    var textStyle2 = themeData.textTheme.bodyText2;
    return Scaffold(
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.5,
              width: double.infinity,
              imageLocation: 'assets/images/dummy2.jpg'),
          SizedBox(
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildHeader(themeData),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: AppColors.color4,
                          elevation: 5,
                          shadowColor: AppColors.color2,
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 18, bottom: 18),
                            child: Text(
                              'Hold tight, dispatch is on its way',
                              style: textStyle1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: AppColors.color4,
                          elevation: 5,
                          shadowColor: AppColors.color2,
                          margin: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 18, bottom: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_location,
                                      color: Colors.black38,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Detected Location',
                                      style: textStyle2,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Hostel (Awo Hall, OAU, Osun State)',
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
