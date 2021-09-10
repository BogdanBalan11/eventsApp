import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:the_last_one/widgets/admin/calendar/calendar.dart';
import 'package:the_last_one/widgets/admin/home/home_user.dart';
import '../widgets/admin/profile/profile.dart';
import '../widgets/admin/settings/settings.dart';

class HomeUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeUserState();
  }
}

class _HomeUserState extends State<HomeUser> {
  int _currentIndex = 0;

  PageController _pageController;

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeUserPage(),
            CalendarPage(),
            ProfilePage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
              activeColor: Colors.blue[900]),
          BottomNavyBarItem(
              title: Text('Calendar'),
              icon: Icon(Icons.calendar_today),
              activeColor: Colors.blue[900]),
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person),
              activeColor: Colors.blue[900]),
          BottomNavyBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings),
              activeColor: Colors.blue[900]),
        ],
      ),
    );
  }
}
