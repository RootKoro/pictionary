import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:pictionary/models/user.model.dart';
// import 'package:pictionary/models/room.model.dart';
import 'package:pictionary/screens/home/room.tile.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    var rooms = FirebaseChatCore.instance.rooms();

    return rooms.length == 0
        ? Text('')
        : StreamBuilder(
            stream: rooms,
            initialData: [],
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) =>
                    RoomTile(room: snapshot.data?[index]),
              );
            },
          );
  }
}
