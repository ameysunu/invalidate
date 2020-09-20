import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invalidatee/homewidget.dart';
import 'package:invalidatee/pages/advantagecare.dart';
import 'login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pedometer/pedometer.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.doc('users/hospi').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#494453'),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/main.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Hexcolor('#D5CCE6'),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Hexcolor('#D5CCE6'),
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gotham',
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                email,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gotham',
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Hexcolor('#FFE8F7'),
                    child: FutureBuilder(
                      future: getUserInfo(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: FutureBuilder(
                                          future: getUserInfo(),
                                          builder: (context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Text(
                                                          "Your bookings",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Gotham',
                                                              fontSize: 20),
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            "Name:\n" +
                                                                snapshot.data
                                                                        .data()[
                                                                    'name'] +
                                                                "\n\nAge:\n" +
                                                                snapshot.data
                                                                        .data()[
                                                                    'age'] +
                                                                "\n\nDate:\n" +
                                                                snapshot.data
                                                                        .data()[
                                                                    'date'] +
                                                                "\n\nHospital:\n" +
                                                                snapshot.data
                                                                        .data()[
                                                                    'hospital'],
                                                            style: TextStyle(
                                                                color: Hexcolor(
                                                                    '#494453'),
                                                                fontFamily:
                                                                    'Gotham',
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: InkWell(
                                                            child: Icon(
                                                                Icons.delete),
                                                            onTap: () {
                                                              _popUpDialog(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.none) {
                                              return Text("No data");
                                            }
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return Text("No data");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/walk.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.38,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "$_steps/6000",
                                  style: TextStyle(
                                      color: Hexcolor('#5C6178'),
                                      fontFamily: 'Gotham',
                                      fontSize: 40),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                            child: Text(
                              "Daily Steps",
                              style: TextStyle(
                                  color: Hexcolor('#5C6178'),
                                  fontFamily: 'Gotham',
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _popUpDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Do you want to delete your booking?",
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
                deleteRecord();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeWidget()),
                );
              }),
        );
      });
}

void deleteRecord() {
  firestoreInstance.collection("users").doc("hospi").update(
      {"name": "", "age": "", "date": "", "hospital": ""}).then((value) {
    print("success");
  });
}
