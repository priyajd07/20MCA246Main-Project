import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FundTransferFirebaseUser {
  FundTransferFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FundTransferFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FundTransferFirebaseUser> fundTransferFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FundTransferFirebaseUser>(
            (user) => currentUser = FundTransferFirebaseUser(user));
