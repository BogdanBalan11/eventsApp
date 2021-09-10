import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:the_last_one/widgets/admin/home/categories/comedy.dart';
import 'package:the_last_one/widgets/admin/home/categories/games.dart';
import 'package:the_last_one/widgets/admin/home/categories/health.dart';
import 'package:the_last_one/widgets/admin/home/categories/music.dart';
import 'package:the_last_one/widgets/admin/home/categories/sport.dart';
import '../../../de folos/appbar.dart';
import '../categories/art.dart';

class Following extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Following'),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('categories')
              .where(">")
              .orderBy("textC")
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => (documents[index]['follow'] == 'yes')
                  ? Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
                        elevation: 15,
                        color: Colors.white,
                        onPressed: () {
                          if (documents[index]['textC'] == 'Art')
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Art(),
                              ),
                            );
                          else if (documents[index]['textC'] == 'Comedy')
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Comedy(),
                              ),
                            );
                          else if (documents[index]['textC'] == 'Games')
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Games(),
                              ),
                            );
                          else if (documents[index]['textC'] == 'Health')
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Health(),
                              ),
                            );
                          else if (documents[index]['textC'] == 'Music')
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Music(),
                              ),
                            );
                          else if (documents[index]['textC'] == 'Sport')
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sport(),
                              ),
                            );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          leading: CachedNetworkImage(
                            height: 70,
                            width: 150,
                            fit: BoxFit.fitWidth,
                            imageUrl: '${documents[index]['link']}',
                          ),
                          title: Text(
                            documents[index]['textC'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          trailing: FavoriteButton(
                            isFavorite: true,
                            valueChanged: null,
                          ),
                        ),
                        //Text(documents[index]['followArt'])
                      ),
                    )
                  : Text(' '),
            );
          },
        ),
      ),
    );
  }
}
