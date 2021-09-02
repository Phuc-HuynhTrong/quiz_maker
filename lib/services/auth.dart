import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> streamUser()   {
    try {
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
    } catch (e) {
      print(e);
    }
    return _auth.authStateChanges();
  }
  User? get getCurrentUser => _auth.currentUser;
  Future signUpWithEmailAndPass(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = getCurrentUser!;
      user.updateDisplayName(name);
      return "sign up";
    } catch (e) {
      print(e);
    }
  }

  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signInWithEmailAndPass(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "sign in";
    }
    catch(e){
      print(e);
    }
  }
}
