import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseAuth getAuth() => _auth;


  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  // sign in anon
  Future signInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      return result.user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password

  // register with email and password

  // sign out

}