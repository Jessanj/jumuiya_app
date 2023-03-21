import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:jumuiya_app/model/event.dart';
import 'package:jumuiya_app/util/extensions.dart';

import '../util/app_colors.dart';
import '../widgets/add_event_widget.dart';
import '../widgets/month_view_widget.dart';

DateTime get _now => DateTime.now();

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return  CalendarControllerProvider<Event>(
      controller: EventController<Event>()..addAll(_events),
      child: MaterialApp(
        title: 'Flutter Calendar Page Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        scrollBehavior: ScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.trackpad,
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: false,
            leading: IconButton(
              onPressed: context.pop,
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.black,
              ),
            ),
            title: Text(
              "Create New Event",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: MonthViewWidget(),
          ),
        ),
      ),
    );
  }
}

List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: Event(title: "Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: Event(title: "Football Tournament"),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    event: Event(title: "Sprint Meeting."),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    event: Event(title: "Team Meeting"),
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    event: Event(title: "Chemistry Viva"),
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];
