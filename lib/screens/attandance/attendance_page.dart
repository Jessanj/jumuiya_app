import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jumuiya_app/screens/attandance/attendance_details.dart';

import '../../Helpers/api_services.dart';
import '../../util/app_colors.dart';
import '../../widgets/left_drawer.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();

}

class _AttendancePageState extends State<AttendancePage> {

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.navyBlue,
          title: const Text('Group Attendance '),
        ),
        drawer:  const Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: LeftDrawer(),
        ),
      body:
      Padding(padding: EdgeInsets.all(2) , child:
      FutureBuilder(
          future: ApiService.getMonthEvent(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index)  {
                  print(snapshot.data![index]);
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceDetails(snapshot.data![index]['event_id'].toString())));
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text((snapshot.data![index]["location"].toString().length >= 18 ) ?snapshot.data![index]["location"].toString().substring(0, 18) :snapshot.data![index]["location"].toString() , style: TextStyle(color: Colors.white),),
                                  Icon(Icons.location_on , color: Colors.white,),
                                ],
                              ),
                              Row(
                                children: [
                                  Text( get_date_from_string(DateTime.parse(snapshot.data![index]['startDate'].toString()) , 'hh : mm a'), style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text( get_date_from_string(DateTime.parse(snapshot.data![index]['startDate'].toString()) , 'd MMM yyyy'), style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.event , color: Colors.green, size: 16,),
                                  Gap(3),
                                  Text(snapshot.data![index]['title'].toString() , style: TextStyle(color: Colors.white), softWrap: true,
                                    maxLines: 2,)

                                ],
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Gap(10),
                                  Column(
                                    children: [
                                      Text('Present' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                      Gap(5),
                                      Text(snapshot.data![index]['present'].toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                    ],
                                  ),
                                  Gap(10),
                                  Column(
                                    children: [
                                      Text('Absent' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                      Gap(5),
                                      Text( (snapshot.data![index]['absent'] +snapshot.data![index]['permitted']).toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                    ],
                                  ),
                                  Gap(10),
                                  Column(
                                    children: [
                                      Text('Guests' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                      Gap(5),
                                      Text(snapshot.data![index]['is_guest'].toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return  Center(
                child: Text('${snapshot.error}'),
              );
            }
            return  Center(
              child: const CircularProgressIndicator(),
            );
          })
      )
    );
  }
}

// Container(
// margin: EdgeInsets.only(top: 40 , right: 10 , left: 10),
// width: MediaQuery.of(context).size.width,
// height: 100,
// decoration: BoxDecoration(
// color: AppColors.lightNavyBlue,
// borderRadius: BorderRadius.circular(20),
// gradient: const LinearGradient(
// colors: [AppColors.attendanceBlue, AppColors.attendanceDBlue],
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// ),
// ),
// padding: const EdgeInsets.only(left: 15 , right: 12 , top: 4 , bottom: 7),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Row(
// children: [
// Text('Dar es salaam' , style: TextStyle(color: Colors.white),),
// Icon(Icons.location_on , color: Colors.white,),
// ],
// ),
// Row(
// children: [
// Text('8:80 AM' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white)),
// ],
// ),
// Row(
// children: [
// Text('12 Jun , 2020' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
// ],
// ),
// ],
// ),
// Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Row(
// children: [
// Icon(Icons.event , color: Colors.green, size: 16,),
// Text('Mkutano wa tatu wa jumuiya 2020' , style: TextStyle(color: Colors.white),),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// const Gap(10),
// Column(
// children: [
// Text('Present' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
// const Gap(5),
// Text('101' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
// ],
// ),
// const Gap(10),
// Column(
// children: [
// Text('Absent' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
// const Gap(5),
// Text('5', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
// ],
// ),
// const Gap(10),
// Column(
// children: [
// Text('Guests' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
// const Gap(5),
// Text('3' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
// ],
// ),
//
// ],
// ),
// ],
// ),
// ],
// ),
//
// );