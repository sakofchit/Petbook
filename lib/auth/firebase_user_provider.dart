import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PetbookFirebaseUser {
  PetbookFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

PetbookFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PetbookFirebaseUser> petbookFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<PetbookFirebaseUser>(
        (user) => currentUser = PetbookFirebaseUser(user));
