import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';

class EmergencyConfirmScreen extends StatefulWidget {
  const EmergencyConfirmScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyConfirmScreen> createState() => _EmergencyConfirmScreenState();
}

class _EmergencyConfirmScreenState extends State<EmergencyConfirmScreen> {
  Container buildHeader(ThemeData themeData) {
    var heading1 = themeData.textTheme.headline1;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'E',
                  style: heading1!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Icon(
            Icons.health_and_safety,
            size: 120,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Emergency?',
            style: heading1.copyWith(color: Colors.white, fontSize: 35),
          ),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle1 = themeData.textTheme.bodyText1;
    var heading1 = themeData.textTheme.headline1;
    var textStyle2 = themeData.textTheme.bodyText2;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildHeader(themeData),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
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
                      padding: const EdgeInsets.all(8),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8),
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
    );
  }
}
