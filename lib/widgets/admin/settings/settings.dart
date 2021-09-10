import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_last_one/widgets/admin/profile/pic.dart';
import '../../de folos/appbar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: barApp('Profile'),
        body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Container(
          alignment: Alignment.center,
          child:ProfilePic(),
        )
      ),);
  }
}
