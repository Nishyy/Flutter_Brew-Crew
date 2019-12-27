import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userDate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew Settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecorator,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a Name' : null,
                    onChanged: (val) {
                      setState(() {
                        this._currentName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecorator,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar Sugars'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentSugars = val;
                      });
                    },
                    value: _currentSugars ?? userData.sugars,
                  ),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    label: '$_currentStrength',
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentSugars ?? userData.sugars,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                      print(_currentName ?? userData.name);
                      print(_currentSugars ?? userData.sugars);
                      print(_currentStrength ?? userData.strength);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  String _currentSugars;

  int _currentStrength;
}
