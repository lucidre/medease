class Appointment {
  final String appointmentLocation;
  final String appointmentDoctor;
  final String status;
  final String dateTimestamp;
  final String timeRange;

  Appointment(
      {required this.appointmentLocation,
      required this.appointmentDoctor,
      required this.status,
      required this.dateTimestamp,
      required this.timeRange});

  static final List<Appointment> dummyAppointments = [
    Appointment(
        appointmentLocation: 'Health Center',
        appointmentDoctor: 'Optician',
        status: 'Pending',
        dateTimestamp: '01-12-2021',
        timeRange: '3:00pm - 5:00pm'),
    Appointment(
        appointmentLocation: 'Health Center',
        appointmentDoctor: 'Cardiologist',
        status: 'Confirmed',
        dateTimestamp: '12-12-2021',
        timeRange: '10:00am - 01:00pm'),
    Appointment(
        appointmentLocation: 'OAU Teaching Hospital',
        appointmentDoctor: 'Radiologist',
        status: 'Denied',
        dateTimestamp: '14-02-2021',
        timeRange: '10:00am - 04:00pm'),
    Appointment(
        appointmentLocation: 'Health Center',
        appointmentDoctor: 'Optician',
        status: 'Pending',
        dateTimestamp: '01-12-2021',
        timeRange: '3:00pm - 5:00pm'),
    Appointment(
        appointmentLocation: 'Health Center',
        appointmentDoctor: 'Cardiologist',
        status: 'Confirmed',
        dateTimestamp: '12-12-2021',
        timeRange: '10:00am - 01:00pm'),
    Appointment(
        appointmentLocation: 'OAU Teach Hospital',
        appointmentDoctor: 'Radiologist',
        status: 'Denied',
        dateTimestamp: '14-02-2021',
        timeRange: '10:00am - 04:00pm'),
    Appointment(
        appointmentLocation: 'Health Center',
        appointmentDoctor: 'Optician',
        status: 'Pending',
        dateTimestamp: '01-12-2021',
        timeRange: '3:00pm - 5:00pm'),
    Appointment(
        appointmentLocation: 'Health Center',
        appointmentDoctor: 'Cardiologist',
        status: 'Confirmed',
        dateTimestamp: '12-12-2021',
        timeRange: '10:00am - 01:00pm'),
    Appointment(
        appointmentLocation: 'OAU Teaching Hospital',
        appointmentDoctor: 'Radiologist',
        status: 'Denied',
        dateTimestamp: '14-02-2021',
        timeRange: '10:00am - 04:00pm'),
  ];
}
