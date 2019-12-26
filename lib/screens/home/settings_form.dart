import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

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
            decoration: textInputDecorator,
            validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
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
            value: _currentSugars ?? '0',
          ),
          //slider
          Slider(
            min: 100,
            max: 900,
            label: '$_currentStrength',
            divisions: 8,
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            value: (_currentStrength ?? 100).toDouble(),
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
              print(_currentName);
              print(_currentStrength);
              print(_currentSugars);
            },
          ),
        ],
      ),
    );
  }

  String _currentSugars;

  int _currentStrength;
}
