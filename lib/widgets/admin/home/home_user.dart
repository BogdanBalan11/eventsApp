import 'package:flutter/material.dart';
import 'package:the_last_one/widgets/admin/home/categories/categories.dart';
import '../../de folos/appbar.dart';
import 'following/following.dart';
import 'wishlist/wish_list.dart';

class HomeUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Dashboard'),
      body: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Star-Event-Logo.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
                        color: Colors.blue[900],
                        padding: EdgeInsets.all(17),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Categories(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.category),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
                        color: Colors.blue[900],
                        padding: EdgeInsets.all(17),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Following(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_forward),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Following',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
                        color: Colors.blue[900],
                        padding: EdgeInsets.all(17),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Wishlist(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.star),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Wish List',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
