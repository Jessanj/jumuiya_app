import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:jumuiya_app/model/event.dart';
import 'package:jumuiya_app/util/extensions.dart';

import '../util/app_colors.dart';
import '../widgets/add_event_widget.dart';
import '../widgets/month_view_widget.dart';

DateTime get _now => DateTime.now();

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        child: AddEventWidget(
        onEventAdd: context.pop,
      ),
      ),
    );
  }
}

