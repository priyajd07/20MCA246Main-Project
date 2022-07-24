//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AdminQrcodeFirebaseUser {
  AdminQrcodeFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

AdminQrcodeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AdminQrcodeFirebaseUser> adminQrcodeFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AdminQrcodeFirebaseUser>(
        (user) => currentUser = AdminQrcodeFirebaseUser(user));
