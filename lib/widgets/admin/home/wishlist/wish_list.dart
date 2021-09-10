import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../de folos/appbar.dart';

class Wishlist extends StatefulWidget {
  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Wishlist'),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events/k4XG9OZKn1V3c6lfHKeQ/Music')
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
              itemBuilder: (ctx, index) => (documents[index]['wishlist'] ==
                      'yes')
                  ? Container(
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
                                    SizedBox(height: 180),
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
                                              Icons.music_note,
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
                    )
                  : Text(" "),
            );
          },
        ),
      ),
    );
  }
}
