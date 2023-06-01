import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:pictionary/components/constants.dart';
import 'package:pictionary/components/globals.dart' as globals;
import 'package:pictionary/models/room.model.dart';
import 'package:pictionary/screens/home/room.dart';
import 'package:pictionary/screens/home/room.list.dart';
import 'package:pictionary/services/auth.dart';
import 'package:pictionary/services/database.dart';
import 'package:pictionary/theme/app_color.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var _authService = AuthService();
  var _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RoomModel>?>.value(
      value: _databaseService.rooms,
      initialData: null,
      child: Scaffold(
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
              onPressed: () async => _authService.signOut(),
              style: textButtonStyle,
              icon: Icon(Icons.logout),
              label: Text('Logout'),
            )
          ],
        ),
        body: RoomList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final users = await FirebaseChatCore.instance.users().first;
            await FirebaseChatCore.instance.createGroupRoom(
              name: FirebaseChatCore.instance.firebaseUser!.email!,
              users: users,
            );
          },
          elevation: 1.5,
          backgroundColor: AppColor.primaryColor,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
