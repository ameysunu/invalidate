import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invalidatee/analyze.dart';
import 'package:invalidatee/home.dart';
import 'package:invalidatee/mapmarker.dart';
import 'package:invalidatee/user.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Home(),
    MapMarker(),
    MyApp(),
    User(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Hexcolor('#D5CCE6'),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home, color: Hexcolor('#494453')),
              title: new Text(
                'Home',
                style:
                    TextStyle(color: Hexcolor('#494453'), fontFamily: 'Gotham'),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.location_on, color: Hexcolor('#494453')),
              title: new Text(
                'Test',
                style:
                    TextStyle(color: Hexcolor('#494453'), fontFamily: 'Gotham'),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.read_more, color: Hexcolor('#494453')),
              title: new Text(
                'Analyze',
                style:
                    TextStyle(color: Hexcolor('#494453'), fontFamily: 'Gotham'),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person, color: Hexcolor('#494453')),
              title: new Text(
                'User',
                style:
                    TextStyle(color: Hexcolor('#494453'), fontFamily: 'Gotham'),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
