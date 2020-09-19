import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invalidatee/login.dart';
import 'package:invalidatee/symptoms.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Hexcolor('#00C3F2'),
                        child: Container(
                          height: 190,
                          width: 150,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Sleep",
                                      style: TextStyle(
                                          fontFamily: 'Gotham',
                                          color: Colors.white70),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.hotel,
                                        color: Colors.white70),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                                child: Text(
                                  "7h 45 min",
                                  style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Keep it up. You have had a goodnight's sleep",
                                  style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 12,
                                      color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Hexcolor('#FFDD85'),
                        child: Container(
                          height: 250,
                          width: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Cases",
                                      style: TextStyle(
                                          fontFamily: 'Gotham',
                                          color: Hexcolor('#494453')),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.dangerous,
                                        color: Hexcolor('#494453')),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                                child: Text(
                                  "30.5 million",
                                  style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 20,
                                      color: Hexcolor('#494453')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Active: 8.8 million\n\nRecovered:20.8 million\n\nDeaths:900k",
                                  style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 12,
                                      color: Hexcolor('#494453')),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                                child: Text(
                                  "Be safe. Wear a mask whenever you go out.",
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 10,
                                    color: Hexcolor('#494453'),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/news.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "News",
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Get latest live news",
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: InkWell(
                                      child: Image.network(
                                          "https://seeklogo.com/images/B/bbc-news-logo-8648ABD044-seeklogo.com.png"),
                                      onTap: () async {
                                        const url =
                                            'https://www.bbc.com/news/health';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: InkWell(
                                      child: Image.network(
                                          "https://seeklogo.com/images/C/CNN-logo-8DA6D1FC28-seeklogo.com.png"),
                                      onTap: () async {
                                        const url =
                                            'https://edition.cnn.com/health';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: InkWell(
                                      child: Image.network(
                                          "https://seeklogo.com/images/N/NBC_News-logo-5C6AD015E2-seeklogo.com.png"),
                                      onTap: () async {
                                        const url =
                                            'https://www.nbcnews.com/health';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
