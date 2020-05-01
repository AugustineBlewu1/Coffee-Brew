import 'package:brew_crew_app/screens/home/authenticate/signIn.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/screens/home/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toogleView() {
    setState(() => showSignIn = !showSignIn);
  }
//var toggleView;

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toogleView);
    } else {
      return Register(toggleView: toogleView);
    }
  }
}
