import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hexcolor/hexcolor.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final firestoreInstance = Firestore.instance;
final nameController = TextEditingController();
final ageController = TextEditingController();
final dateController = TextEditingController();

class CityMD extends StatefulWidget {
  @override
  _CityMDState createState() => _CityMDState();
}

class _CityMDState extends State<CityMD> {
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2080));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Hexcolor('#FFCAAE'),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Hexcolor('#FFCAAE'),
          title: Text(
            "COVID Testing Center",
            style: TextStyle(
                fontFamily: 'Gotham', color: Colors.black, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset('images/hospitals/citymd.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "CityMD Lower East Side Urgent Care - NYC",
                  style: TextStyle(
                      fontFamily: 'Gotham', color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 35, 0),
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
                  decoration: new InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                        fontFamily: 'Gotham',
                        color: Colors.black54,
                        fontSize: 15),
                    labelStyle:
                        TextStyle(fontFamily: 'Gotham', color: Colors.black),
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 35, 0),
                child: TextFormField(
                  controller: ageController,
                  style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
                  decoration: new InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                        fontFamily: 'Gotham',
                        color: Colors.black54,
                        fontSize: 15),
                    labelStyle:
                        TextStyle(fontFamily: 'Gotham', color: Colors.black),
                    icon: Icon(
                      Icons.accessibility_new_outlined,
                      color: Colors.black,
                    ),
                    hintText: 'How old are you?',
                    labelText: 'Age *',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Card(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          color: Colors.white,
                          child: Text('Select Date'),
                          onPressed: () {
                            _selectDate(context);
                          }),
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: dateController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText:
                                "${selectedDate.toLocal()}".split(' ')[0],
                            labelStyle: TextStyle(
                                color: Colors.white, fontFamily: "Gotham"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Book',
                            style: TextStyle(
                              fontFamily: 'Gotham',
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dateController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                      _popup(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void createRecord() {
  firestoreInstance.collection("users").doc("hospi").update({
    "name": nameController.text,
    "age": ageController.text,
    "date": dateController.text,
    "hospital": "City MD Lower East Side Urgent Care - NYC"
  }).then((value) {
    print("success");
  });
}

void _popup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Do you want to confirm your booking?",
              style: TextStyle(fontFamily: 'Gotham'),
            ),
          ),
          content: RaisedButton(
              color: Colors.black,
              child: Text(
                "Yes",
                style: TextStyle(fontFamily: "Gotham", color: Colors.white),
              ),
              onPressed: () {
                createRecord();
                Navigator.of(context).pop();
              }),
        );
      });
}
