import 'package:flutter/material.dart';
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
    final heading1 = textTheme.headline1;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  CustomPageRoute(screen: const DoctorListAppointmentScreen()));
            },
          ),
        ],
        title: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            'My Appointments',
            style: heading1!.copyWith(fontSize: 22, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildHeaderLayout(textStyle1, textStyle2),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Appointments',
                  style: textStyle1,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
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
                      itemCount: Appointment.dummyAppointments.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (ctx, index) {
                        return buildAppointmentItem(textStyle1, textStyle2,
                            Appointment.dummyAppointments[index]);
                      },
                    )
            ],
          ),
        ),
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
      margin: const EdgeInsets.all(6.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointments.appointmentDoctor,
                  style: textStyle1,
                ),
                Text(
                  appointments.status,
                  style: textStyle2!.copyWith(color: AppColors.color6),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
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
              height: 6,
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
              height: 6,
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

  Container buildHeaderLayout(TextStyle? textStyle1, TextStyle? textStyle2) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: AppColors.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(83),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              child: Image.asset(
                'assets/images/avatar_1.jpg',
                width: 160,
                height: 160,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
            height: 25,
          ),
        ],
      ),
    );
  }
}
