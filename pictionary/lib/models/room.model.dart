import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class RoomModel {
  final String? id;
  final types.User? owner;

  RoomModel({this.id, this.owner});
}
