import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
    String role,
  ) submitFn;
//
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  /*nu se pot declansa toate validatoarele in acelasi timp in Form, e nevoie de un 
 GlobalKey, care anunta dart ca some Form state will be managed with this key */
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  String role = 'user';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    /*va verifica daca totul e ok cu datele introduse in casete */

    FocusScope.of(context).unfocus(); //inchide tastatura dupa ce sunt introduse
    //datele

    if (isValid) {
      _formKey.currentState.save();
      /* it will go to all the text form fiels and
      on every text form field si va declansa onSaved function*/

      //dupa ce e validat, putem folosi variabilele si pt firebase

      widget.submitFn(
        _userEmail.trim(), //.trim() sterge spatiile care sunt introduse
        _userPassword.trim(),
        _userName.trim(), //in casete
        _isLogin,
        context,
        role,
      );
      //executa functia din clasa AuthForm, ai nevoie de widget. ca sa o poti
      //accesa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, //ocupa doar spatiul de care are
                  //nevoie
                  children: [
                    TextFormField(
                      /*key ii permite lui sa identifice unic elementele similare
                      daca acestea sunt unele langa altele (se muta textul de la
                      parola la username atunci cand schimbam modul log in-sign up) */
                      key: ValueKey('email'),
                      /* validator =a function that validates the user input */
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email adress.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(1),
                            child: Icon(Icons.email)),
                        labelText: 'Email adress',
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(Icons.person),
                            ),
                            labelText: 'Username'),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(Icons.security)),
                          labelText: 'Password'),
                      obscureText:
                          true, //ascunde textul cand e introdusa o parola
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Sign up'),
                        onPressed: _trySubmit,
                      ),
                    if (!widget.isLoading)
                      //FlatButton va fi folosit ca sa schimbam intre log in si sign up
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
