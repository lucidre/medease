class DoctorAppointmentDetail {
  final String dayOfTheWeek;
  final String timeLocation;
  final String venue;

  DoctorAppointmentDetail(
      {required this.dayOfTheWeek,
      required this.timeLocation,
      required this.venue});

  static final dummyData = [
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Wednesday, December 1, 2021',
        timeLocation: '2:00pm - 5:00pm',
        venue: 'Health Center'),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Thursday, November 12, 2020',
        timeLocation: '4:00pm - 5:00pm',
        venue: 'Onikan Health Center '),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Monday, January 2, 2021',
        timeLocation: '10:00am - 12:00pm',
        venue: 'Yaba Central'),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Wednesday, December 1, 2021',
        timeLocation: '2:00pm - 5:00pm',
        venue: 'Health Center'),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Thursday, November 12, 2020',
        timeLocation: '4:00pm - 5:00pm',
        venue: 'Onikan Health Center '),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Monday, January 2, 2021',
        timeLocation: '10:00am - 12:00pm',
        venue: 'Yaba Central'),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Wednesday, December 1, 2021',
        timeLocation: '2:00pm - 5:00pm',
        venue: 'Health Center'),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Thursday, November 12, 2020',
        timeLocation: '4:00pm - 5:00pm',
        venue: 'Onikan Health Center '),
    DoctorAppointmentDetail(
        dayOfTheWeek: 'Monday, January 2, 2021',
        timeLocation: '10:00am - 12:00pm',
        venue: 'Yaba Central'),
  ];
}
