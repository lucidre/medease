import 'package:flutter/material.dart';

import '../helper_widgets/blue_image.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../main/drawer_screen.dart';
import 'emergency_confirm_screen.dart';

//screen to send emergency to the health center
class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _dropDownKey = GlobalKey<ScaffoldState>();
  static const String select = "Please select item";
  String emergency = select;
  String otherEmergency = "";
  bool _isOtherEmergency = false;
  final TextEditingController _otherEmergencyController =
      TextEditingController(text: '');

  void openItemsList() {
    GestureDetector? detector;
    void search(BuildContext? ctx) {
      ctx?.visitChildElements((element) {
        if (detector != null) return;
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
        } else {
          search(element);
        }
      });
    }

    search(_dropDownKey.currentContext);
    if (detector != null) detector!.onTap!();
  }

  @override
  void initState() {
    super.initState();
    _otherEmergencyController.addListener(() {
      otherEmergency = _otherEmergencyController.text;
    });
  }

  @override
  void dispose() {
    _otherEmergencyController.dispose();
    super.dispose();
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
    var height = MediaQuery.of(context).size.height;
    var textStyle1 = themeData.textTheme.bodyText1;
    var textStyle2 = themeData.textTheme.bodyText2;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.5,
              width: double.infinity,
              imageLocation: 'assets/images/dummy2.jpg'),
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
                        left: 20, right: 20, top: 25, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'What is going on?',
                          style: textStyle1!.copyWith(fontSize: 28),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Please ensure your device location is turned on to ensure swift location tracking',
                          style: textStyle2!.copyWith(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Text('Blood Group', style: textStyle1)),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: AppColors.color4,
                            elevation: 3,
                            shadowColor: AppColors.color2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 5, bottom: 5),
                              child: GestureDetector(
                                onTap: openItemsList,
                                child: DropdownButtonFormField(
                                  key: _dropDownKey,
                                  items: [
                                    select,
                                    'Accident',
                                    'Death',
                                    'Cardiac Arrest',
                                    'Sudden Breathing Problem',
                                    'Eye Trauma',
                                    "Others"
                                  ]
                                      .map(
                                        (val) => DropdownMenuItem<String>(
                                          child: Text(val),
                                          value: val,
                                        ),
                                      )
                                      .toList(),
                                  value: emergency,
                                  hint: const Text(
                                      'Please select the emergency nature'),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 20,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent))),
                                  style: textStyle2,
                                  onChanged: (value) {
                                    emergency = (value as String?) ?? "Death";
                                    if (value == 'Others' &&
                                        !_isOtherEmergency) {
                                      setState(() {
                                        _isOtherEmergency = true;
                                      });
                                    } else if (_isOtherEmergency) {
                                      setState(() {
                                        _isOtherEmergency = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        _isOtherEmergency
                            ? const SizedBox(
                                height: 20,
                              )
                            : Container(),
                        _isOtherEmergency
                            ? SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                      labelText: 'Other  Emergency',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 3))),
                                  style: textStyle2,
                                  controller: _otherEmergencyController,
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              elevation: 5,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(CustomPageRoute(
                                  screen: const EmergencyConfirmScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Text(
                                'Send Request',
                                style: textStyle2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
