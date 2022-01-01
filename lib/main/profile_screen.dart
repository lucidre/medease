import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medease/user_model.dart';
import 'package:provider/provider.dart';

import '../auth/pick_signin_or_signup.dart';
import '../helper_widgets/colors.dart';
import '../helper_widgets/page_route.dart';
import '../listeners/menu_model.dart';
import '../main.dart';
import '../user/user_edit_profile_screen.dart';
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
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    final heading1 = textTheme.headline1;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            'My Profile',
            style: heading1!.copyWith(fontSize: 22, color: Colors.black),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: handleMenuItems,
            itemBuilder: (ctx) => [
              PopupMenuItem<int>(
                child: Text(
                  'Edit Profile',
                  style: textStyle2,
                ),
                value: 0,
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeaderLayout(textStyle1, textStyle2),
              const SizedBox(
                height: 15,
              ),
              GridView(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                          style: textStyle1,
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
                          style: textStyle1,
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
                          style: textStyle1,
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
                          style: textStyle1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleMenuItems(int result) {
    switch (result) {
      case 0:
        {
          Navigator.of(context).push(
            CustomPageRoute(screen: const UserEditProfileScreen()),
          );
          break;
        }
      case 1:
        {
          break;
        }
      case 2:
        {
          Navigator.of(context).pushAndRemoveUntil(
              CustomPageRoute(screen: const PickSignInOrLoginScreen()),
              (route) => false);
          break;
        }
    }
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
            UserPref.userFullName,
            style: textStyle1!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            UserPref.userRegistration,
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
