import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../de folos/appbar.dart';

class Music extends StatefulWidget {
  @override
  State<Music> createState() => _MusicState();
}

List<int> numara = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

class _MusicState extends State<Music> {
  void _addMusicUntold(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('events/k4XG9OZKn1V3c6lfHKeQ/Music')
        .doc('NDPlho2yxlZqESKq9yOU')
        .update({
      'wishlist': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addMusicNostalgia(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('events/k4XG9OZKn1V3c6lfHKeQ/Music')
        .doc('ibZV4EQrB9ADGK4xrNVL')
        .update({
      'wishlist': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addMusicElectric(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('events/k4XG9OZKn1V3c6lfHKeQ/Music')
        .doc('5dZ1PSVJghxP36Rdaf3P')
        .update({
      'wishlist': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Music'),
      body: StreamBuilder(
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
            itemBuilder: (ctx, index) => double.parse(
                        documents[index]['date'].toString().substring(0, 4)) >=
                    double.parse('${DateTime.now().year}')
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
                                  FlatButton(
                                    // padding: EdgeInsets.only(left: 185),
                                    onPressed: () {
                                      setState(() {
                                        numara[index]++;
                                        if (index == 0)
                                          _addMusicUntold(numara, index);
                                        else if (index == 1)
                                          _addMusicNostalgia(numara, index);
                                        else if (index == 2)
                                          _addMusicElectric(numara, index);
                                      });
                                    },
                                    child:
                                        (documents[index]['wishlist'] == 'no')
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      color: Colors.grey,
                                                      onPressed: () {
                                                        setState(() {
                                                          numara[index]++;
                                                          _addMusicUntold(
                                                              numara, index);
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    color: Colors.grey,
                                                    onPressed: () {
                                                      setState(() {
                                                        numara[index]++;
                                                        _addMusicUntold(
                                                            numara, index);
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete),
                                                  ),
                                                  Text(
                                                    'Remove from wishlist',
                                                    style: TextStyle(
                                                        color: Colors.white),
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
    );
  }
}
