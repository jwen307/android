import 'package:brewcrew/screens/wrapper.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:brewcrew/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      //Specify which stream to listen to
      value: AuthService().user,

      //Since these widgets are wrapped in the stream provider, they can access the values from the stream
      child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}
