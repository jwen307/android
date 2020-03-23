import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';

class Signin extends StatefulWidget {

  //Set a function to toggle the view from sign in to register
  final Function toggleView;
  Signin({this.toggleView});      //This is a constructor

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  //Create an authservice instance to handle the authentication services
  final AuthService _auth = AuthService();

  //Variable to associate this form
  final _formKey = GlobalKey<FormState>();

  //Variable to see if the page is loading
  bool loading = false;

  // Text Field state to keep track of the email and password
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(  //Checks if loading is true, if not show the Scaffold, if it is, show the loading widget
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation:0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            }
          ),
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
                //A field for the email
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  //Set the validation requirements
                  validator: (val) => val.isEmpty ? 'Enter an email': null,
                  onChanged: (val) {
                    //Set the email variable to the current value
                    setState(() => email = val);
                  },
                ),
                SizedBox(height:20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                   //Check if the value is longer than 6 characters
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                  //Obscure the password after a short period of time
                  obscureText: true,
                  onChanged:(val) {
                    //Set the password to the current value
                    setState(() => password = val);
                  }
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    //Check if the form is valid based on the validation set in the widget
                    if(_formKey.currentState.validate())
                    {
                      setState(() => loading = true);   //Start the loading widget
                      dynamic result = await _auth.signInWithEmailandPassword(email, password);
                      if (result == null){
                        setState(() {
                          error = 'Could not sign with those credientials';
                          loading = false;
                        });
                      }
                      //Because the stream listener, the home page will be shown automatically on the registration is successful
                    }
                  },
                ),
                SizedBox(height:12.0),
                Text(error, style:TextStyle(color: Colors.red, fontSize: 14.0)),
          ],)
        ),
      ),
    );
  }
}