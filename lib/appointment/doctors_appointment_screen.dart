import 'package:flutter/material.dart';

import '../helper_widgets/blue_image.dart';
import '../helper_widgets/colors.dart';
import '../models/doctor_appointment_detail.dart';
import '../models/doctor_list.dart';

class DoctorsAppointmentScreen extends StatefulWidget {
  const DoctorsAppointmentScreen({Key? key}) : super(key: key);

  @override
  _DoctorsAppointmentScreenState createState() =>
      _DoctorsAppointmentScreenState();
}

class _DoctorsAppointmentScreenState extends State<DoctorsAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    var doctorList = ModalRoute.of(context)?.settings.arguments as DoctorList;
    var height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1;
    final bodyText2 = textTheme.bodyText2;

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
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 3,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorList.name,
                                style: bodyText1!.copyWith(
                                    fontSize: 35, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                doctorList.location,
                                style: bodyText2!.copyWith(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
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
                      itemCount: DoctorAppointmentDetail.dummyData.length,
                      itemBuilder: (ctx, index) {
                        return buildItem(bodyText1, bodyText2,
                            DoctorAppointmentDetail.dummyData[index]);
                      },
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

  Card buildItem(TextStyle? textStyle1, TextStyle? textStyle2,
      DoctorAppointmentDetail appointmentDetail) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: AppColors.color4,
      elevation: 6,
      shadowColor: AppColors.color2,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointmentDetail.dayOfTheWeek,
              style: textStyle1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.more_time, color: Colors.black54),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  appointmentDetail.timeLocation,
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
                  appointmentDetail.venue,
                  style: textStyle2,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: textStyle2!.copyWith(
                      color: Colors.white,
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text('Reserve a spot')),
            ),
          ],
        ),
      ),
    );
  }
}
