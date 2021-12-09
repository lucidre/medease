import 'package:flutter/material.dart';
import 'package:medease/appointment/doctors_appointment_screen.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/helper_widgets/page_route.dart';
import 'package:medease/models/doctor_list.dart';

class DoctorListAppointmentScreen extends StatefulWidget {
  const DoctorListAppointmentScreen({Key? key}) : super(key: key);

  @override
  _DoctorListAppointmentScreenState createState() =>
      _DoctorListAppointmentScreenState();
}

class _DoctorListAppointmentScreenState
    extends State<DoctorListAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var bodyText1 = textTheme.bodyText1;
    var bodyText2 = textTheme.bodyText2;
    var headingText = textTheme.headline1;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              'Book An Appointment',
              style: headingText!.copyWith(fontSize: 22),
            ),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: DoctorList.dummyList.length,
            itemBuilder: (ctx, index) {
              return buildListItem(
                  bodyText1, bodyText2, DoctorList.dummyList[index]);
            }));
  }

  Card buildListItem(
      TextStyle? bodyText1, TextStyle? bodyText2, DoctorList doctorList) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      color: AppColors.color4,
      elevation: 5,
      shadowColor: AppColors.color2,
      margin: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CustomPageRoute(
              screen: const DoctorsAppointmentScreen(), argument: doctorList));
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, right: 10, left: 10, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(44)),
                child: Image.asset(
                  'assets/images/avatar_1.jpg',
                  width: 88,
                  height: 88,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doctorList.name,
                        style: bodyText1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            doctorList.location,
                            style: bodyText2,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(Icons.add_location, color: Colors.black54),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
