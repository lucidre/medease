import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper_widgets/blue_image.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../listeners/menu_model.dart';
import '../main.dart';
import '../user/user_edit_profile_screen.dart';
import '../user_model.dart';
import 'drawer_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    });
  }

  @override
  void didPush() {
    Future.delayed(
        Duration.zero,
        () => (Provider.of<MenuModelListener>(context, listen: false))
            .updatePosition(MenuModel.home));
    super.didPush();
  }

  @override
  void didPopNext() {
    Future.delayed(
        Duration.zero,
        () => (Provider.of<MenuModelListener>(context, listen: false))
            .updatePosition(MenuModel.home));
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1;
    final bodyText2 = textTheme.bodyText2;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.4,
              width: double.infinity,
              imageLocation: 'assets/images/dummy9.jpg'),
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
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                                screen: const UserEditProfileScreen()),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 30, bottom: 30),
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
                                UserPref.userFullName,
                                style: bodyText1!.copyWith(
                                    fontSize: 35, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                UserPref.userRegistration,
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
                    child: GridView(
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.color4,
                          elevation: 8,
                          shadowColor: AppColors.color2,
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Basic Info',
                                style: bodyText1,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.color4,
                          elevation: 8,
                          shadowColor: AppColors.color2,
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'My Documents',
                                textAlign: TextAlign.center,
                                style: bodyText1,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.color4,
                          elevation: 8,
                          shadowColor: AppColors.color2,
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'My Appointments',
                                textAlign: TextAlign.center,
                                style: bodyText1,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.color4,
                          elevation: 8,
                          shadowColor: AppColors.color2,
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Reviews',
                                textAlign: TextAlign.center,
                                style: bodyText1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
