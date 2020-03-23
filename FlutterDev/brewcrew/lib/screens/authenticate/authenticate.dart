import 'package:brewcrew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/screens/authenticate/register.dart';


class Authenticate extends StatefulWidget {

  
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  //Value to decide if sign in page or register page should be shown
  bool showSignIn = true;
  //Change the showSign. Pass this function to the other widgets
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return Signin(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}