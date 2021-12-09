import 'package:flutter/material.dart';
import 'package:medease/emergency/emergency_confirm_screen.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';
import 'package:medease/main/drawer_screen.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
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
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(themeData),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'What is going on?',
                    style: textStyle1,
                  ),
                  const SizedBox(
                    height: 15,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            style: textStyle2,
                            onChanged: (value) {
                              emergency = (value as String?) ?? "Death";
                              if (value == 'Others' && !_isOtherEmergency) {
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
                        textStyle: textStyle2.copyWith(
                          color: Colors.white,
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            screen: const EmergencyConfirmScreen()));
                      },
                      child: const Text(
                        'Send Request',
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
    );
  }
}
