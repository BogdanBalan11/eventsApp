import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:the_last_one/widgets/admin/home/add%20event/event.dart';
import '../../../de folos/appbar.dart';
import 'new_event.dart';

class MyEvents extends StatefulWidget {
  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  final List<Event> _userEvents = [];

  // List<Event> get _adminEvents {
  //   return _userEvents.where((tx) {
  //     return tx.creator.contains('admin');
  //   }).toList();
  // }

  void _addNewEvent(
      String name,
      String image,
      DateTime date,
      String category,
      String location,
      String cost,
      String duration,
      String about,
      String creator,
      String id) {
    final newTx = Event(
      name: name,
      image: image,
      date: date,
      category: category,
      location: location,
      cost: cost,
      duration: duration,
      about: about,
      creator: creator,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userEvents.add(newTx);
    });
  }

  void _startAddNewEvent(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewEvent(_userEvents, _addNewEvent),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  // void _deleteEvent(String id) {
  //   setState(() {
  //     _userEvents.removeWhere((tx) {
  //       return tx.id == id;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Add Event'),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/elon.jpg'),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10),
              //alignment: Alignment.center,
              child: Text(
                'Great news from space, it looks like you are cool enough to create an event, just press the button below',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: FloatingActionButton(
                backgroundColor: Colors.blue[900],
                onPressed: () => _startAddNewEvent(context),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
