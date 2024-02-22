import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jumuiya_app/models/event.dart';
import 'package:jumuiya_app/screens/week_view_page.dart';
import 'package:jumuiya_app/util/extensions.dart';

import '../Helpers/api_services.dart';
import '../util/app_colors.dart';
import '../util/app_layouts.dart';
import '../util/app_styles.dart';
import '../widgets/add_event_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/month_view_widget.dart';
import 'attandance/attendance_details.dart';
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
  var events;
  @override
  initState(){
    super.initState();
    events = ApiService.getEvents();
  }

  String get_date_from_string(DateTime parseDate , String format) {
    // Define the date format string.
    String date_format = format;

    // Create a DateFormat object with the date format string.
    String data  = DateFormat(date_format).format(parseDate).toString();

    // Return the date.
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final size  =  AppLayouts.getSize(context);
    LangItem defaultLang = lang.first;


    checkEventDate(String start , String end){

       if(start == end){
         return 'same';
       }
       if(get_date_from_string(DateTime.parse(start), 'd' ) !=  get_date_from_string(DateTime.parse(end), 'd') && get_date_from_string(DateTime.parse(start), 'MM' ) ==  get_date_from_string(DateTime.parse(end), 'MM') ){

         return 'day-diff-same-m';
       }
       if(get_date_from_string(DateTime.parse(start), 'MM' ) !=  get_date_from_string(DateTime.parse(end), 'MM') ){
         return 'month-diff';
       }
    }

    return  Scaffold(
          appBar: AppBar(
            title: const Text('Events & Schedule') ,
            backgroundColor: AppColors.navyBlue,
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
            child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.navyBlue),
                          ),
                          onPressed: () => context.pushRoute(CreateEventPage()),
                          child: const Text("Add Event"),
                        ),
                        const Gap(5),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.navyBlue),
                            ),
                          onPressed: () => context.pushRoute(MonthViewPage()),
                          child: const Text("Month View"),
                        ),
                        const Gap(5),
                        ElevatedButton(
                          style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.navyBlue),
                          ),
                          onPressed: () => context.pushRoute(WeekViewPage()),
                          child:  const Text("Week View"),
                        ),

                      ],
                    ),
                    const Gap(10),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: FutureBuilder<List<Event>>(
                            future: ApiService.getEvents(),
                            builder: (context, snapshot){
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsDetails(snapshot.data![index]['event_id'].toString())));
                                      },

                                      child: Container(
                                        margin: EdgeInsets.only(top: 8 , right: 10 , left: 10),
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: AppColors.lightNavyBlue,
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            colors: [AppColors.attendanceBlue, AppColors.attendanceDBlue],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                        padding: const EdgeInsets.only(left: 15 , right: 12 , top: 4 , bottom: 7),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.event , color: Colors.white,),
                                                Text((snapshot.data![index].title.toString().length > 18 ) ?snapshot.data![index].title.toString().substring(0, 18) :snapshot.data![index].title.toString() , style: TextStyle(fontSize: 18 ,color: Colors.white),),
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text( get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()) , 'hh : mm a'), style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white)),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text( get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()) , 'd MMM yyyy'), style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Icon(Icons.location_on , color: Colors.green, size: 16,),
                                                        Gap(3),
                                                        Text((snapshot.data![index].location.toString().length > 21 ) ?snapshot.data![index].location.toString().substring(0, 21) :snapshot.data![index].location.toString() , style: TextStyle(color: Colors.white),),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                print('error happen');
                                return Text('${snapshot.error}');
                              }
                              return const  Center(
                                child:
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
                                  )
                              );
                            }),
                      ),
                    ),
                  ],
                )
          )
      );
  }
}

