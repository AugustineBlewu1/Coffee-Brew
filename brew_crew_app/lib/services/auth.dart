import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase object
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
//user Stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //Sign in Annoy

  Future signInAonn() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignIn
  Future signInwithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with email and password

  Future registerwithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user

      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Signout

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
