import 'dart:core';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute(
  { required Widget screen}
  ) : super(
          pageBuilder: (_, __, ___) => screen,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget widget) {
            return Opacity(
              opacity: animation.value,
              child: widget,
            );
          },
          transitionDuration: const Duration(milliseconds: 1500),
        );
}
