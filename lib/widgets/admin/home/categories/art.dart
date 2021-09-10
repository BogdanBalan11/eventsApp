import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../de folos/appbar.dart';

class Art extends StatefulWidget {
  @override
  State<Art> createState() => _ArtState();
}

class _ArtState extends State<Art> {
  List<int> numara = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Art'),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events/k4XG9OZKn1V3c6lfHKeQ/Art')
            .where(">")
            .orderBy("date")
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            padding: EdgeInsets.only(left: 20, top: 15),
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Stack(
                      children: [
                        Container(
                          height: 210,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: '${documents[index]['image']}',
                          ),
                        ),
                        Column(
                          children: [
                            FlatButton(
                              // padding: EdgeInsets.only(left: 185),
                              onPressed: () {
                                setState(() {
                                  numara[index]++;
                                });
                              },
                              child: (numara[index] % 2 == 0)
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            color: Colors.grey,
                                            onPressed: () {
                                              setState(() {
                                                numara[index]++;
                                              });
                                            },
                                            icon: Icon(Icons.star)),
                                        Text(
                                          'Add to wishlist',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          color: Colors.grey,
                                          onPressed: () {
                                            setState(() {
                                              numara[index]++;
                                            });
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                        Text(
                                          'Remove from wishlist',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                            ),
                            SizedBox(height: 130),
                            Positioned(
                                right: 10,
                                left: 10,
                                bottom: 10,
                                // top: 140,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      documents[index]['date'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Icon(
                                      Icons.photo,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.only(right: 185),
                        child: Text(
                          '${documents[index]['name']}, ${documents[index]['cost']} €',
                          style: TextStyle(
                            fontSize: 23,
                            wordSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                      Text(
                        '${documents[index]['location']}',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
