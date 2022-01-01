import 'package:flutter/material.dart';

import '../helper_widgets/blue_image.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../models/doctor_list.dart';
import 'doctors_appointment_screen.dart';

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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        BlueImageContainer(
            height: height * 0.4,
            width: double.infinity,
            imageLocation: 'assets/images/dummy7.jpg'),
        SizedBox(
          height: height,
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Book An Appointment',
                        textAlign: TextAlign.center,
                        style: bodyText1!.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
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
                      left: 10, right: 10, top: 15, bottom: 10),
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: DoctorList.dummyList.length,
                      itemBuilder: (ctx, index) {
                        return buildListItem(
                            bodyText1, bodyText2, DoctorList.dummyList[index]);
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(44)),
                child: Image.asset(
                  'assets/images/avatar_1.jpg',
                  width: 70,
                  height: 70,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doctorList.name,
                        style: bodyText2!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(
                        height: 6,
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
