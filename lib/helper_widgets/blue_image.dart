import 'package:flutter/material.dart';

import 'colors.dart';

class BlueImageContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imageLocation;
  final double headerTopSpacer;
  final bool showHeader;

  const BlueImageContainer(
      {Key? key,
      required this.height,
      required this.width,
      required this.imageLocation,
      this.headerTopSpacer = 0,
      this.showHeader = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        foregroundDecoration: const BoxDecoration(
          color: AppColors.color8,
        ),
        child: Image.asset(
          imageLocation,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: headerTopSpacer,
        child: showHeader
            ? Image.asset(
                'assets/images/full_logo.png',
                height: 100,
                color: Colors.white,
                width: 250,
                fit: BoxFit.contain,
              )
            : Container(),
      ),
    ]);
  }
}
