import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_last_one/screens/user_screen.dart';
import 'package:the_last_one/widgets/de%20folos/auth_helper.dart';
import 'package:the_last_one/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_last_one/screens/splash_screen.dart';
import 'package:the_last_one/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Star Events',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                backgroundColor: Colors.blue,
                accentColor: Colors.lightBlue,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.blue,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )),
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder<User>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        UserHelper.saveUser(snapshot.data);
                        return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(snapshot.data.uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final userDoc = snapshot.data;
                              final user = userDoc.data();
                              if (user['role'] == 'admin') {
                                return HomeAdmin();
                              } else {
                                return HomeUser();
                              }
                            } else {
                              return Material(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        );
                      }
                      return AuthScreen();
                    }),
          );
        });
  }
}
