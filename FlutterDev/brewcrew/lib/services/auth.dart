import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  //Create an instance of FirebaseAuth to access the authenication functions
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Creat a user object from a Firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    //Check if the Firebase user is null. If not, return a User object with just the user.id
    return user != null? User(uid: user.uid) : null;
  }


  // Auth change user stream (check if the user is signed in)
  Stream<User> get user{
    //Every time a user signs in or out, send the change as a User object mapped from Firebase user
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  //Methods for signing in

  // Sign in anonomously
  Future signInAnon() async{

    try{
      //Try signing in anonymously. Return the result of the attempt as an AuthResult object
      AuthResult result =  await _auth.signInAnonymously();

      //Create a user
      FirebaseUser user = result.user;

      //Return the custom user object
      return _userFromFirebaseUser(user);

    } 
    
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailandPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }  

  // Register with email and password
  Future registerWithEmailandPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a document for the user when registering
      await DatabaseService(uid: user.uid).updateUserData('0','new crew member',100);
      
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }



}