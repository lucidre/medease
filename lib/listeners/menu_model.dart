import 'package:flutter/material.dart';

class MenuModel {
  final String name;
  final IconData iconData;
  final int position;

  MenuModel(
      {required this.name, required this.iconData, required this.position});

  static const home = 0;
  static const upload = 1;
  static const emergency = 2;
  static const bookAppointment = 3;
  static const aboutUs = 4;
  static const signOut = 5;

  static final mainMenuModels = [
    MenuModel(iconData: Icons.home, name: 'Home', position: home),
    MenuModel(iconData: Icons.note, name: 'Upload Document', position: upload),
    MenuModel(
        iconData: Icons.health_and_safety,
        name: 'Emergency',
        position: emergency),
    MenuModel(
        iconData: Icons.note_outlined,
        name: 'Book Appointment',
        position: bookAppointment),
    MenuModel(iconData: Icons.info, name: 'About Us', position: aboutUs),
  ];
  static final otherMenuModels = [
    MenuModel(iconData: Icons.exit_to_app, name: 'Sign Out', position: signOut),
  ];
}

class MenuModelListener with ChangeNotifier {
  int _selectedPosition = 0;

  void updatePosition(int newPosition) {
    if (_selectedPosition == newPosition) return;
    _selectedPosition = newPosition;
    notifyListeners();
  }

  int get selectedPosition => _selectedPosition;
}
