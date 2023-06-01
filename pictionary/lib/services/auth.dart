import 'package:firebase_auth/firebase_auth.dart';
import 'package:pictionary/models/user.model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseAuth(User? user) {
    return user != null ? UserModel(uid: user.uid, email: user.email) : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseAuth);
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential? credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credentials.user;
      return _userFromFirebaseAuth(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: user?.email,
          id: user!.uid,
        ),
      );
      return _userFromFirebaseAuth(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
