import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:pictionary/components/constants.dart';
import 'package:pictionary/components/globals.dart' as globals;
import 'package:pictionary/models/drawing.point.dart';
import 'package:pictionary/models/room.model.dart';
import 'package:pictionary/models/user.model.dart';
import 'package:pictionary/services/auth.dart';
import 'package:pictionary/services/draw.dart';
import 'package:pictionary/theme/app_color.dart';
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  final AuthService _authService = AuthService();
  final DrawService _drawService = DrawService();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // DrawingPoint? _drawingPoint;

  bool isPauseDialogOpen = false;
  String username = "";
  DrawingPoint? points;

  Duration defaultDuration = const Duration(seconds: 30);
  Timer? timer;
  Duration currentDuration = Duration.zero;

  @override
  Future<void> initState() async {
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer({bool startOver = true}) {
    /// only start over if the timer is null
    if (timer != null) return;

    if (startOver) {
      currentDuration = defaultDuration;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDuration -= const Duration(seconds: 1);
      // context.read<DrawingCubit>().playerTicker(currentDuration.inSeconds);
      if (currentDuration.inSeconds == 0) {
        // context.read<DrawingCubit>().playerTimeout();
        stopTimer();
      }
    });
  }

  void stopTimer() {
    /// only stop  if the timer is not null
    if (timer == null) return;

    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    username = user!.email!;
    points = _drawService.draw(null, null);
    return Scaffold(
      backgroundColor: AppColor.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 1.0,
        title: Text(
          FirebaseChatCore.instance.firebaseUser!.email!,
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              _authService.signOut();
              Navigator.pop(context);
            },
            style: textButtonStyle,
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          )
        ],
      ),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            points = DrawingPoint(
              id: globals.room!.id!,
              offsets: [details.localPosition],
              paint: Paint()
                ..color = Colors.black
                ..isAntiAlias = true
                ..strokeWidth = 5
                ..strokeCap = StrokeCap.round,
            );
          });
        },
        onPanUpdate: (details) {
          setState(() {
            points!.offsets.add(details.localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            points = null;
          });
        },
        child: CustomPaint(
          painter: _DrawingPainter(drawingPoints: points),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 50,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final DrawingPoint? drawingPoints;

  _DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    if (drawingPoints != null) {
      for (var pointOffset in drawingPoints!.offsets) {
        canvas.drawPoints(
            PointMode.points, drawingPoints!.offsets, drawingPoints!.paint!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// class Room extends StatelessWidget {
//   Room({super.key});
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: AppColor.backgroundWhite,
    //   appBar: AppBar(
    //     backgroundColor: AppColor.primaryColor,
    //     elevation: 1.0,
    //     title: Text(
    //       FirebaseChatCore.instance.firebaseUser!.email!,
    //       style: TextStyle(fontSize: 15),
    //     ),
    //     actions: [
    //       TextButton.icon(
    //         onPressed: () async {
    //           _authService.signOut();
    //           Navigator.pop(context);
    //         },
    //         style: textButtonStyle,
    //         icon: Icon(Icons.logout),
    //         label: Text('Logout'),
    //       )
    //     ],
    //   ),
    //   body: Text(globals.room!.id!),
    // );
//   }
// }
