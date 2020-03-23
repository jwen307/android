import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:provider/provider.dart';



//Widget for the bottom screen to change the settings
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //Form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  

  @override
  Widget build(BuildContext context) {

    //Create a variable to store the stream data from the provider
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        //Check if the snapshot has data, if so, update the form
        if(snapshot.hasData){
          
          //Get the snapshot data
          UserData userData = snapshot.data;

          return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your brew settings',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              TextFormField( 
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20.0),

              //Dropdown
              DropdownButtonFormField( 
                decoration: textInputDecoration,
                value: _currentSugars ?? userData.sugars,
                items: sugars.map((sugar){
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val),
              ),

              //Slider
              Slider( 
                value: (_currentStrength ?? userData.strength).toDouble(), //If current strength is not null, set to _current strength
                activeColor: Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                min: 100,
                max: 900,
                divisions: 8,
                onChanged: (val) => setState(() => _currentStrength = val.round()),
              ),

              //Button to update
              RaisedButton( 
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars ?? userData.sugars,
                      _currentName ?? userData.name,
                      _currentStrength ?? userData.strength
                    );
                    Navigator.pop(context);   //Brings down the bottom sheet after the button has been pressed. 
                  }
                }
              ),
            ],
          ),
          
        );
        }
        else{
          return Loading();
        }
        
      }
    );
  }
}