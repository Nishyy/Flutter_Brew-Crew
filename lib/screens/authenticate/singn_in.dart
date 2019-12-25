import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleViewFun;

  SignIn({this.toggleViewFun});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String errorString = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Regester'),
            onPressed: () {
              widget.toggleViewFun();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecorator.copyWith(hintText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    this.email = value;
                  });
                },
                validator: (val) => val.isEmpty ? "Enter an Email" : null,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecorator.copyWith(hintText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    this.password = value;
                  });
                },
                validator: (val) => val.length < 6
                    ? "Enter a password greater than 6 char long"
                    : null,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =
                        await _auth.signInWithEmail(email, password);
                    if (result == null) {
                      setState(() {
                        errorString = 'Could not sing with this Credentials';
                        loading = false;
                      });
                    }
                    print(email);
                    print(password);
                  }
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                errorString,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
