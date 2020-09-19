import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'homewidget.dart';

String name;
String email;
String imageUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Hexcolor('#FFE8F7'),
        appBar: AppBar(
          backgroundColor: Hexcolor('#FFE8F7'),
          elevation: 0,
          title: Text(
            "Invalidate",
            style: TextStyle(color: Hexcolor('#52424D'), fontFamily: 'Gotham'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  child: Text(
                      "Let's fight the pandemic by making you stronger.",
                      style: TextStyle(
                          color: Hexcolor('#52424D'),
                          fontFamily: 'Gotham',
                          fontSize: 17)),
                ),
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset('images/home.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Let's get you signed up!",
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 20,
                      color: Hexcolor('#52424D')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset('images/google.png'),
                        ),
                      ),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                            fontFamily: 'Gotham', color: Hexcolor('#52424D')),
                      )
                    ],
                  ),
                  onPressed: () {
                    signInWithGoogle().then((result) {
                      if (result != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeWidget();
                            },
                          ),
                        );
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "By signing in, you are agreeing to Google's terms and policies.",
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      color: Colors.black54,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
