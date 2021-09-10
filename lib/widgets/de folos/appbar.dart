import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar barApp(String title) {
  return AppBar(
    backgroundColor: Colors.blue[900],
    title: Text(title),
    actions: [
      DropdownButton(
        //A dropdown button lets the user select from a number of items
        icon: Icon(
          Icons.more_vert, //alea 3 puncte
          color: Colors.white,
        ),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.grey,
                  ), //semn de log out
                  SizedBox(width: 8),
                  Text('Log out'),
                ],
              ),
            ),
            value: 'Logout',
          )
        ],
        onChanged: (itemIdentifier) {
          if (itemIdentifier == 'Logout') {
            FirebaseAuth.instance.signOut();
          }
        },
      )
    ],
  );
}
