import 'package:brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/screens/home/brews_list.dart';
import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/screens/home/settings_form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
            child: SettingsForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Crew"),
          backgroundColor: Colors.brown[400],
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Log out")),
            FlatButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text("settings"),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
