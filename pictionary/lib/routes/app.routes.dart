import 'package:flutter/material.dart';
import 'package:pictionary/routes/name.route.dart';
import 'package:pictionary/screens/home/room.dart';
// import 'package:pictionary/screens/auth/authenticate.dart';
// import 'package:pictionary/screens/home/home.dart';
import 'package:pictionary/screens/wrapper.dart';
// import 'package:pictionary/screens/draw/presentation/drawing_screen.dart';
// import 'package:pictionary/screens/room/presentation/room_screen.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.home:
        return MaterialPageRoute(
          builder: (_) => Wrapper(),
          settings: settings,
        );

      case AppRouteName.drawingRoom:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Room(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
    }

    return null;
  }
}
