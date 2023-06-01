import 'package:flutter/material.dart';
// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:pictionary/models/room.model.dart';
import 'package:pictionary/components/globals.dart' as globals;
import 'package:pictionary/models/room.model.dart';
import 'package:pictionary/routes/name.route.dart';
// import 'package:pictionary/services/database.dart';
import 'package:pictionary/theme/app_color.dart';

class RoomTile extends StatelessWidget {
  final dynamic room;

  RoomTile({super.key, this.room});

  @override
  Widget build(BuildContext context) {
    return room == null
        ? Text('')
        : Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
              child: TextButton(
                onPressed: () {
                  globals.room =
                      RoomModel(id: room.id, owner: room.users.first);
                  Navigator.pushNamed(context, AppRouteName.drawingRoom);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: AppColor.primarySwatch[200],
                  ),
                  title: Text(room.name),
                  subtitle: Text(room.id),
                ),
              ),
            ),
          );
  }
}
