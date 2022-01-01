import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../about_us/about_us_screen.dart';
import '../appointment/user_appointment_screen.dart';
import '../auth/login_screen.dart';
import '../document_upload/registration/document_registration1.dart';
import '../emergency/emergency_screen.dart';
import '../helper_widgets/auth.dart';
import '../helper_widgets/blue_imagency_screen.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../listeners/menu_model.dart';
import 'profile_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  MenuModelListener? _modelListener;

  void onMenuItemClicked(MenuModel model) {
    var navigatorState = Navigator.of(context);
    navigatorState.pop();
    _modelListener?.updatePosition(MenuModel.mainMenuModels.indexOf(model));

    switch (model.position) {
      case MenuModel.home:
        {
          navigatorState.pushAndRemoveUntil(
              CustomPageRoute(screen: const ProfileScreen()), (route) => false);
          break;
        }
      case MenuModel.emergency:
        {
          navigatorState.pushAndRemoveUntil(
              CustomPageRoute(screen: const EmergencyScreen()),
              (route) => route.isFirst);
          break;
        }

      case MenuModel.signOut:
        {
          logOut();
          navigatorState.pushAndRemoveUntil(
              CustomPageRoute(screen: const LoginScreen()), (route) => false);
          break;
        }

      case MenuModel.upload:
        {
          navigatorState.pushAndRemoveUntil(
              CustomPageRoute(screen: const DocumentUpload1Screen()),
              (route) => route.isFirst);
          break;
        }
      case MenuModel.aboutUs:
        {
          navigatorState.pushAndRemoveUntil(
              CustomPageRoute(screen: const AboutUsScreen()),
              (route) => route.isFirst);
          break;
        }
      case MenuModel.bookAppointment:
        {
          navigatorState.pushAndRemoveUntil(
              CustomPageRoute(screen: const UserAppointmentScreen()),
              (route) => route.isFirst);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    _modelListener = Provider.of<MenuModelListener>(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var textStyleNormal = themeData.textTheme.bodyText1
        ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500);
    var textStyleSelected = themeData.textTheme.bodyText1?.copyWith(
      fontSize: 18,
      color: Colors.white,
    );

    return Drawer(
      elevation: 8,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            BlueImageContainer(
                height: height * 0.4,
                width: double.infinity,
                imageLocation: 'assets/images/dummy1.jpg'),
            Column(
              children: [
                SizedBox(
                  height: height * 0.065,
                ),
                Image.asset(
                  'assets/images/full_logo.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 150,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...MenuModel.mainMenuModels.map((model) {
                        return buildMenuItems(
                            MenuModel.mainMenuModels.indexOf(model) ==
                                _modelListener?.selectedPosition,
                            model,
                            textStyleSelected,
                            textStyleNormal);
                      }).toList(),
                      const SizedBox(
                        height: 3,
                      ),
                      Divider(
                        color: (MediaQuery.of(context).platformBrightness ==
                                Brightness.dark)
                            ? Colors.white70
                            : Colors.black38,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          'Settings',
                          style: textStyleNormal,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ...MenuModel.otherMenuModels.map((model) {
                        return buildMenuItems(
                            false, model, textStyleSelected, textStyleNormal);
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItems(bool isSelected, MenuModel model,
      TextStyle? textStyleSelected, TextStyle? textStyleNormal) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        color: (isSelected)
            ? AppColors.color6.withOpacity(0.85)
            : Colors.transparent,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
        minLeadingWidth: 10,
        leading: Icon(model.iconData,
            size: 20, color: (isSelected) ? Colors.white : Colors.black87),
        onTap: () {
          onMenuItemClicked(model);
        },
        title: Text(
          model.name,
          maxLines: 1,
          style: (isSelected) ? textStyleSelected : textStyleNormal,
        ),
      ),
    );
  }
}
