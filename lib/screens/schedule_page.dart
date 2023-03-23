import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/model/event.dart';
import 'package:jumuiya_app/screens/week_view_page.dart';
import 'package:jumuiya_app/util/extensions.dart';

import '../util/app_colors.dart';
import '../util/app_layouts.dart';
import '../widgets/add_event_widget.dart';
import '../widgets/month_view_widget.dart';
import 'create_event_page.dart';
import 'month_view_page.dart';

import '../widgets/left_drawer.dart';
import 'notifications_page.dart';

class LangItem {
  const LangItem(this.name,this.icon);
  final String name;
  //final ImageIcon icon;
  final Icon icon;
}

DateTime get _now => DateTime.now();

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<LangItem> lang = [
    const LangItem('ENG', Icon(Icons.flag),),
    const LangItem('KISW', Icon(Icons.flag_circle_outlined),),
  ];

  @override
  Widget build(BuildContext context) {
    final size  =  AppLayouts.getSize(context);
    LangItem defaultLang = lang.first;

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
            actions: <Widget>[
              DropdownButton(
                value: defaultLang ,
                style: const TextStyle(color: Colors.deepPurple),
                items: lang.map((LangItem lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Row(
                      children: [
                        lang.icon,
                        const SizedBox(width: 10, ),
                        Text(
                          lang.name,
                          style:  const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    defaultLang = value!;
                  });
                },
              ),
              const SizedBox(width: 10, ),
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Notifications',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationPage()),
                  );
                },
              ),
            ],
          ),
          drawer:  const Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: LeftDrawer(),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.pushRoute(CreateEventPage()),
                      child: const Text("Add Event"),
                    ),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: () => context.pushRoute(MonthViewPage()),
                      child: const Text("Month View"),
                    ),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: () => context.pushRoute(WeekViewPage()),
                      child:  const Text("Week View"),
                    ),

                  ],
                ),
                // MonthViewWidget(),
              ],
            ),
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
