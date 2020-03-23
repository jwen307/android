import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';

class Register extends StatefulWidget {
  
  //Set a function to toggle the view from sign in to register
  final Function toggleView;
  Register({this.toggleView});

  
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //Create an authservice instance to handle the authentication services
  final AuthService _auth = AuthService();

  //Variable to associate this form
  final _formKey = GlobalKey<FormState>();

  //See if it is loading
  bool loading = false;

  // Text Field state to keep track of the email and password
  String email = '';
  String password = '';
  String error = '';
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation:0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
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
                  decoration: textInputDecoration.copyWith(hintText: 'Email'), //This is a custom input decoration defined in the shared/constants.dart file
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
                  //Obscure the password after a short period of time
                  obscureText: true,
                  //Check if the value is longer than 6 characters
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                  onChanged:(val) {
                    //Set the password to the current value
                    setState(() => password = val);
                  }
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    //Check if the form is valid based on the validation set in the widget
                    if(_formKey.currentState.validate())
                    {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailandPassword(email, password);
                      if (result == null){
                        setState(() {
                          error = 'please supply a valid email';
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