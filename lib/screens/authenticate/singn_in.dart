import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

final Function toggleViewFun;

SignIn({this.toggleViewFun});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    this.email = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    this.password = value;
                  });
                },
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
                  print(email);
                  print(password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
