import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../de folos/appbar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

dynamic allData;
CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('events/k4XG9OZKn1V3c6lfHKeQ/Music');

Future<void> getDataMusic() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  //for (int i = 0; i < allData.length; i++) lista.add(allData[i]);
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barApp('Calendar'),
      body: SfCalendar(
        allowedViews: [
          CalendarView.day,
          CalendarView.week,
          CalendarView.month,
        ],
        // onTap: (_) {
        //   getDataMusic();
        // },
        view: CalendarView.month,
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  getDataMusic();
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  for (int i = 0; i < allData.length; i++)
    meetings.add(
      Appointment(
          startTime: DateTime.parse(allData[i]['date']),
          endTime: DateTime.parse(allData[i]['date']),
          subject: allData[i]['name'],
          color: Colors.blue,
          //recurrenceRule: 'FREQ=DAILY;COUNT=10',
          isAllDay: true,
          location: allData[i]['location']),
    );

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
