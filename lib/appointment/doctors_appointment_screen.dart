import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';
import 'package:medease/models/doctor_appointment_detail.dart';
import 'package:medease/models/doctor_list.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildHeaderLayout(textStyle1, textStyle2, doctorList),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: DoctorAppointmentDetail.dummyData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return buildItem(textStyle1, textStyle2,
                      DoctorAppointmentDetail.dummyData[index]);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Card buildItem(TextStyle? textStyle1, TextStyle? textStyle2,
      DoctorAppointmentDetail appointmentDetail) {
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
                  child: const Text('Book this appointment')),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHeaderLayout(
      TextStyle? textStyle1, TextStyle? textStyle2, DoctorList doctorList) {
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
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(73),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(70)),
              child: Image.asset(
                'assets/images/avatar_1.jpg',
                width: 140,
                height: 140,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            doctorList.name,
            style: textStyle1!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            doctorList.location,
            style: textStyle2!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
