import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/blue_image.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';
import 'package:medease/main/drawer_screen.dart';
import 'package:medease/models/appointment.dart';

import 'doctors_list_appointment_screen.dart';

class UserAppointmentScreen extends StatefulWidget {
  const UserAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<UserAppointmentScreen> createState() => _UserAppointmentScreenState();
}

class _UserAppointmentScreenState extends State<UserAppointmentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.4,
              width: double.infinity,
              imageLocation: 'assets/images/dummy7.jpg'),
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        Expanded(
                          child: Text(
                            'My Appointments',
                            textAlign: TextAlign.center,
                            style: textStyle1!.copyWith(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(CustomPageRoute(
                                screen: const DoctorListAppointmentScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Appointment.dummyAppointments.isEmpty
                              ? Container(
                                  height: 300,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: const Text(
                                    'No appointments yet, please click the + button to add one',
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      Appointment.dummyAppointments.length,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (ctx, index) {
                                    return buildAppointmentItem(
                                        textStyle1,
                                        textStyle2,
                                        Appointment.dummyAppointments[index]);
                                  },
                                )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card buildAppointmentItem(
      TextStyle? textStyle1, TextStyle? textStyle2, Appointment appointments) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      color: AppColors.color4,
      elevation: 5,
      shadowColor: AppColors.color2,
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointments.appointmentDoctor,
                  style: textStyle2!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  appointments.status,
                  style: textStyle2.copyWith(color: AppColors.color6),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.more_time, color: Colors.black54),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  appointments.dateTimestamp,
                  style: textStyle2,
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.date_range, color: Colors.black54),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  appointments.timeRange,
                  style: textStyle2,
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_location, color: Colors.black54),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  appointments.appointmentLocation,
                  style: textStyle2,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
