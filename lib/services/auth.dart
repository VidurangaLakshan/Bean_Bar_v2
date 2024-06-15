import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteuser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }
}