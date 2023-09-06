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

    return MaterialApp(
        title: 'Schedule and Events Page',
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
                                    // return Container(
                                    //   alignment: Alignment.topLeft,
                                    //   margin: const EdgeInsets.only(right: 5 , top: 5 , bottom: 5),
                                    //   height: 110,
                                    //   width: size.width*0.5,
                                    //   padding: const EdgeInsets.only(left: 5, right: 5),
                                    //   decoration: const BoxDecoration(
                                    //       color: AppColors.barBg,
                                    //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                                    //   ),
                                    //   child: Column(
                                    //       mainAxisAlignment: MainAxisAlignment.start,
                                    //       children: [
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.center,
                                    //           children: [
                                    //             Padding(
                                    //               padding: const EdgeInsets.only(left: 2 , right: 2),
                                    //               child: Text(snapshot.data![index].title,
                                    //                 style: const TextStyle(
                                    //                   fontFamily: "Poppins",
                                    //                   fontWeight: FontWeight.w500,
                                    //                   fontSize: 18,
                                    //                 ),
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.start,
                                    //           children: [
                                    //             Container(
                                    //                 height: 80,
                                    //                 width: 80,
                                    //                 padding: EdgeInsets.only(left: 5 , right: 5),
                                    //                 alignment: Alignment.center,
                                    //                 decoration: BoxDecoration(
                                    //                   color: AppColors.primary_bg_border,
                                    //                   borderRadius: BorderRadius.circular(5),
                                    //                 ),
                                    //                 child: Column(
                                    //                   mainAxisAlignment: MainAxisAlignment.center,
                                    //                   children: [
                                    //                     Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'd').toString() , style: Styles.headLineStyle2w,) ,
                                    //                     Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'MMM').toString() , style: Styles.headLineStyle2w,) ,
                                    //                   ],
                                    //                 )
                                    //             ),
                                    //             const Gap(5),
                                    //             Expanded(
                                    //                 child: Text(snapshot.data![index].description.toString(),
                                    //                   style: const TextStyle(
                                    //                       fontFamily: "Poppins",
                                    //                       fontWeight: FontWeight.w500,
                                    //                       fontSize: 14
                                    //                   ),
                                    //                 )
                                    //             )
                                    //           ],
                                    //         ),
                                    //
                                    //       ]
                                    //   ),
                                    // );
                                    return  Padding(padding: EdgeInsets.only(top: 5 , bottom: 5) , child:
                                    SizedBox(
                                        height: 90,
                                        // width: size.width*0.5,
                                        child :
                                        ListTile(
                                          leading: Container(
                                              width: 100,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.primary_bg_border,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  (checkEventDate(snapshot.data![index].startDate.toString(),snapshot.data![index].endDate.toString()) == 'day-diff-same-m') ?
                                                  Column(
                                                    children: [
                                                      Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'd').toString()+' - '+get_date_from_string(DateTime.parse(snapshot.data![index].endDate.toString()), 'd MMM').toString() , style: Styles.headLineStyle3,),
                                                      Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'h:mm a').toString() , style: Styles.headLineStyle3,)
                                                    ],
                                                  ) :
                                                  (checkEventDate(snapshot.data![index].startDate.toString(),snapshot.data![index].endDate.toString()) == 'month-diff') ?
                                                  Column(
                                                    children: [
                                                      Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'd MMM').toString() , style: Styles.headLineStyle3,),
                                                      Text('to' , style: Styles.headLineStyle4),
                                                      Text(get_date_from_string(DateTime.parse(snapshot.data![index].endDate.toString()), 'd MMM').toString() , style: Styles.headLineStyle3,),
                                                    ],
                                                  ) :
                                                  (checkEventDate(snapshot.data![index].startDate.toString(),snapshot.data![index].endDate.toString()) == 'same') ?
                                                  Column(
                                                    children: [
                                                      Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'd MMM').toString() , style: Styles.headLineStyle3,),
                                                      Text(get_date_from_string(DateTime.parse(snapshot.data![index].startDate.toString()), 'h:mm a').toString(), style: Styles.headLineStyle3,)
                                                    ],
                                                  ) : Container() ,

                                                ],
                                              )
                                          ),
                                          title: Text(snapshot.data![index].title+' ('+snapshot.data![index].location.toString()+')'),
                                          subtitle: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(snapshot.data![index].description.toString()),
                                            ],
                                          ),
                                          tileColor: AppColors.barBg,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: BorderSide(color: Colors.black38),
                                          ),

                                        )
                                    ));
                                  },
                                );
                              } else if (snapshot.hasError) {
                                print('duh error');
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
        ),
      );
  }
}

