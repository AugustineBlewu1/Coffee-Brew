import 'package:brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/shared/constants.dart';
import 'package:brew_crew_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state

  String email;
  String password;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text("Sign in Brew"),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register')),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? "enter an email" : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val.length < 6
                                ? "enter a password 6+ chars"
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            }),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.pink[400],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInwithEmailPassword(email, password);

                              if (result == null) {
                                setState(() {
                                  error =
                                      "Couldnot sign in with user credentials";
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0))
                      ],
                    ),
                  )),
            ),
          );
  }
}
