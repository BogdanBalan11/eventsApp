import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_last_one/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_last_one/widgets/de%20folos/background_image.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
    String role,
  ) async //Asynchronous operations let your program complete work while
  //waiting for another operation to finish.
  /* common asynchronous operations:Fetching data over a network,
Writing to a database, Reading data from a file

 A future represents the result of an asynchronous operation

 await: You can use the await keyword to get the completed result of an 
 asynchronous expression.The await keyword only works within an async function.
 */
  {
    UserCredential authResult;
    try {
      /*prinde erori daca sunt introduse
  date invalide(email/parola) */
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ); //logheaza userul
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password, //creeaza userului un cont
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          //the extra info you store in a document is a map
          'email': email,
          'username': username,
          'role': role,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      /*mesaj ce apare in josul
      ecranului */
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundImage(),
      Container(
        padding: EdgeInsets.only(top: 50, left: 10),
        height: 100,
        child: Image.asset('assets/images/Star-Event-Logo.png',
            fit: BoxFit.fitHeight),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: AuthForm(_submitAuthForm, _isLoading),
      ),
    ]);
  }
}
