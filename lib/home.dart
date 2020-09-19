import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invalidatee/login.dart';
import 'package:invalidatee/symptoms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }), ModalRoute.withName('/'));
              }),
        ],
        title: Text(
          "Hello $name",
          style: TextStyle(fontFamily: 'Gotham', color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Card(
                    color: Hexcolor('#FFE8F7'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                          child: Text(
                            "Symptoms",
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 20.0),
                          child: Text(
                            "Feeling sick? Let's see how we can help?",
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                        Row(
                          children: [],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Symptoms()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
