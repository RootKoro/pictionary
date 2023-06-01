// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:pictionary/models/room.model.dart';
import 'package:pictionary/models/user.model.dart';

class DatabaseService {
  final FirebaseChatCore _firebaseChatCore = FirebaseChatCore.instance;
  final String? id;
  final UserModel? owner;

  DatabaseService({this.owner, this.id});

  List<RoomModel> _roomListFromFireChatCore(List<types.Room> rooms) {
    return rooms.map((room) {
      return RoomModel(id: room.id, owner: room.users.first);
    }).toList();
  }

  RoomModel _roomFromFireChatCore(types.Room room) {
    return RoomModel(id: room.id, owner: room.users.first);
  }

  Stream<List<RoomModel>> get rooms {
    return _firebaseChatCore.rooms().map(_roomListFromFireChatCore);
  }

  Stream<RoomModel>? get room {
    return id == null
        ? null
        : _firebaseChatCore.room(id!).map(_roomFromFireChatCore);
  }

  Future<types.Room> createRoom(String name) async {
    var users = await _firebaseChatCore.users().toList();
    return await _firebaseChatCore.createGroupRoom(name: name, users: users[0]);
  }

  void updateRoom(types.Room room) {
    _firebaseChatCore.updateRoom(room);
  }

  Future<void> deleteRoom(String id) async {
    await _firebaseChatCore.deleteRoom(id);
  }
}
