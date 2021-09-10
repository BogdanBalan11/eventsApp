import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:the_last_one/widgets/admin/home/categories/art.dart';
import 'package:the_last_one/widgets/admin/home/categories/comedy.dart';
import 'package:the_last_one/widgets/admin/home/categories/games.dart';
import 'package:the_last_one/widgets/admin/home/categories/health.dart';
import 'package:the_last_one/widgets/admin/home/categories/music.dart';
import 'package:the_last_one/widgets/admin/home/categories/sport.dart';
import '../../../de folos/appbar.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

var lista = [0, 0, 0, 0, 0, 0];

class _CategoriesState extends State<Categories> {
  void _addFollowArt(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc('UpqgZZLwkBloqbBW8WT0')
        .update({
      'follow': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addFollowComedy(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc('Lxu4FR3b4ouQiRLuKXIK')
        .update({
      'follow': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addFollowGames(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc('XxJXql2wTYdOeLxuiIzO')
        .update({
      'follow': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addFollowHealth(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc('F1mxiMeI4Hjlg4gnik4l')
        .update({
      'follow': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addFollowMusic(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc('bbaRoelrcaIEmnJ0TG2d')
        .update({
      'follow': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  void _addFollowSport(List<int> lista, int index) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc('EP8J9L0u1hjrndJCDxE0')
        .update({
      'follow': lista[index] % 2 == 0 ? 'no' : 'yes',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Categories'),
      body: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/category.jpg'),
                ),
              ),
            ),
          ),
          Flexible(
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
                  itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    child: RaisedButton(
                      elevation: 15,
                      color: Colors.white,
                      onPressed: () {
                        documents[index]['textC'] == 'Art'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Art(),
                                ),
                              )
                            : documents[index]['textC'] == 'Comedy'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Comedy(),
                                    ),
                                  )
                                : documents[index]['textC'] == 'Games'
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Games(),
                                        ),
                                      )
                                    : documents[index]['textC'] == 'Health'
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Health(),
                                            ),
                                          )
                                        : documents[index]['textC'] == 'Music'
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Music(),
                                                ),
                                              )
                                            : documents[index]['textC'] ==
                                                    'Sport'
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Sport(),
                                                    ),
                                                  )
                                                : null;
                      },
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        leading: CachedNetworkImage(
                          height: 70,
                          width: 150,
                          fit: BoxFit.fitWidth,
                          imageUrl: documents[index]['link'],
                        ),
                        title: Text(
                          documents[index]['textC'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        trailing: FavoriteButton(
                          isFavorite: documents[index]['follow'] == 'yes'
                              ? true
                              : false,
                          valueChanged: (_isFavorite) {
                            if (_isFavorite == true)
                              lista[index] = 1;
                            else
                              lista[index] = 0;

                            _isFavorite = !_isFavorite;

                            if (documents[index]['textC'] == 'Art')
                              _addFollowArt(lista, index);
                            else if (documents[index]['textC'] == 'Comedy')
                              _addFollowComedy(lista, index);
                            else if (documents[index]['textC'] == 'Games')
                              _addFollowGames(lista, index);
                            else if (documents[index]['textC'] == 'Health')
                              _addFollowHealth(lista, index);
                            else if (documents[index]['textC'] == 'Music')
                              _addFollowMusic(lista, index);
                            if (documents[index]['textC'] == 'Sport')
                              _addFollowSport(lista, index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
