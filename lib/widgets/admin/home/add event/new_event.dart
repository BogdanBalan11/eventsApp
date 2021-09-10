import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'event.dart';

class NewEvent extends StatefulWidget {
  final List<Event> events;
  final Function addTx;
  NewEvent(this.events, this.addTx);
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  DateTime _selectedDate;
  final _categoryController = TextEditingController();
  final _locationController = TextEditingController();
  final _costController = TextEditingController();
  final _durationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _creatorController = TextEditingController();
  final _idController = TextEditingController();
  final enteredName = '';
  void _submitData() {
    // if (_nameController.text.isEmpty) {
    //   return;
    // }
    final enteredName = _nameController.text;
    final enteredImage = _imageController.text;
    final enteredCategory = _categoryController.text;
    final enteredLocation = _locationController.text;
    final enteredCost = _costController.text;
    final enteredDuration = _durationController.text;
    final enteredAbout = _aboutController.text;
    final enteredCreator = _creatorController.text;
    final enteredId = _idController.text;

    // if (enteredName.isEmpty ||
    //     enteredImage.isEmpty ||
    //     enteredCategory.isEmpty ||
    //     enteredLocation.isEmpty ||
    //     enteredAbout.isEmpty ||
    //     enteredCreator.isEmpty ||
    //     enteredId.isEmpty ||
    //     _selectedDate == null) return;

    widget.addTx(
        enteredName,
        enteredImage,
        _selectedDate,
        enteredCategory,
        enteredLocation,
        enteredCost,
        enteredDuration,
        enteredAbout,
        enteredCreator,
        enteredId);
    _add();
    Navigator.of(context).pop();
  }

  void _add() {
    //for (int i = 0; i < widget.events.length; i++)
    FirebaseFirestore.instance
        .collection('events/k4XG9OZKn1V3c6lfHKeQ/Games')
        .doc('mZApGymz2tezLhkkV4do')
        .update({
      'name': widget.events[widget.events.length - 1].name,
      'image': widget.events[widget.events.length - 1].image,
      'date': widget.events[widget.events.length - 1].date
          .toIso8601String()
          .substring(0, 10),
      'category': widget.events[widget.events.length - 1].category,
      'location': widget.events[widget.events.length - 1].location,
      'cost': widget.events[widget.events.length - 1].cost,
      'duration': widget.events[widget.events.length - 1].duration,
      'about': widget.events[widget.events.length - 1].about,
      'creator': 'admin',
      'id': '0',
      'wishlist': 'no',
      // 'category':selec
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //prima caseta
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),

              //a doua caseta
              TextField(
                decoration: InputDecoration(labelText: 'Image'),
                controller: _imageController,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),

              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen'
                            : (DateFormat.yMd().format(_selectedDate)),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),

              TextField(
                decoration: InputDecoration(labelText: 'Category'),
                controller: _categoryController,
                onSubmitted: (_) => _submitData(),
              ),

              //a doua caseta
              TextField(
                decoration: InputDecoration(labelText: 'Location'),
                controller: _locationController,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),

              TextField(
                decoration: InputDecoration(labelText: 'Cost €'),
                controller: _costController,
                onSubmitted: (_) => _submitData(),
              ),

              //a doua caseta
              TextField(
                decoration: InputDecoration(labelText: 'Duration'),
                controller: _durationController,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),

              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                controller: _aboutController,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),

              //buton de add
              RaisedButton(
                child: Text('Add event'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).buttonColor,
                onPressed: _submitData,
              ),
              SizedBox(
                height: 260,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
