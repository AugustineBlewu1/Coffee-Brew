import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/screens/home/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
