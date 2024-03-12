import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/Helpers/api_services.dart';
import 'package:jumuiya_app/models/attendance.dart';
import 'package:jumuiya_app/models/user.dart';

import '../../util/app_colors.dart';
import '../../util/app_styles.dart';
import '../../util/constants.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AttendanceDetails extends StatefulWidget {

   final String eventId;
   const AttendanceDetails(this.eventId);

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  String status = '';
  String searchTerm = '';

  Map<String, Function> statusActions = {
    "present": () => Container(
      child: const Icon(Icons.done_outline, color: Colors.green),
    ),
    "absent": () => Container(
      child: const Icon(Icons.group_off, color: Colors.red),
    ),
    "permitted": () => Container(
      child: const Icon(Icons.done_all, color: Colors.orange),
    ),
  };

  var present = 0 ;
  var absent = 0;
  var geust = 0;
  var remains = 0;
  var all = 0;


  @override
  void initState() {
    super.initState();
    getAttendanceData();
  }

  void getAttendanceData(){
    var attendanceData =  ApiService.getAttendance(widget.eventId);
    // present = attendanceData.then((value) => value.where((item) => status == 'present').length);

    attendanceData.then((data){
      setState(() {
        all = data.length;
        present = data.where((item) => item['status'] == 'present').length;
        absent = (data.where((item) => item['status'] == 'absent').length) + (data.where((item) => item['status'] == 'permitted').length);
        geust = data.where((item) => item['is_guest'] == true).length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      backgroundColor: AppColors.navyBlue,
      ),

     floatingActionButton: SizedBox(
       width: 100,
       child: FloatingActionButton(
           onPressed: () {
             // Do something
           },
           backgroundColor: AppColors.navyBlue,
           elevation: 20,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
           ),
           child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [ Icon(Icons.add), Text('Guests'),])
       ),
     ) ,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Gap(10),
              Column(
                children: [
                  Text(AppLocalizations.of(context)!.present , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black)),
                  Gap(5),
                  Text(present.toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                ],
              ),
              Gap(10),
              Column(
                children: [
                  Text(AppLocalizations.of(context)!.absent  , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black)),
                  Gap(5),
                  Text( absent.toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                ],
              ),
              Gap(10),
              Column(
                children: [
                  Text(AppLocalizations.of(context)!.guest  , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black)),
                  Gap(5),
                  Text(geust.toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                ],
              ),
              Gap(10),
              Column(
                children: [
                  Text(AppLocalizations.of(context)!.remains  , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black)),
                  Gap(5),
                  Text((all - (present+absent)).toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                ],
              ),

            ],
          ),
          const Gap(20),
          Padding(
            padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom:100),
              decoration:  AppConstants.inputDecorationForms.copyWith(
                  hintText: AppLocalizations.of(context)!.filter_search,
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  suffixIcon: Icon(Icons.filter_list , color: Colors.grey.shade600, size: 20,)
              ),
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
            ),
          ),
          const Gap(5),
          Expanded(
            child:  FutureBuilder(
              future: ApiService.getAttendance(widget.eventId),
              builder:  (context, snapshot){
                if(snapshot.hasData){
                  return  ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final userattendance = snapshot.data![index];
                      return (userattendance['full_name'].toLowerCase().contains(searchTerm.toLowerCase()))  ?
                        Container(
                            margin:EdgeInsets.only(top: 3 , bottom: 3 , left: 15 , right: 15) ,
                            decoration: BoxDecoration(
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                            title: Text(
                                "${userattendance['full_name']}" , style: TextStyle(color: Colors.grey.shade600, fontSize: 20,)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    var attendance = jsonEncode({
                                      'event_id' : widget.eventId,
                                      'status' : 'present',
                                      'user_id' : userattendance['user_id']
                                    });
                                    var response = ApiService.addAttendance(attendance);
                                    setState(() {
                                      // present++;
                                      getAttendanceData();
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.check , color: Colors.green,  size: 28,),
                                      Text(AppLocalizations.of(context)!.present_, style: TextStyle(color: Colors.green , fontWeight: FontWeight.bold),),
                                    ],),
                                ),
                                TextButton(
                                  onPressed: () {
                                    var attendance = jsonEncode({
                                      'event_id' : widget.eventId,
                                      'status' : 'absent',
                                      'user_id' : userattendance['user_id']
                                    });
                                    var response = ApiService.addAttendance(attendance);
                                    setState(() {
                                      status = "Absent";
                                      getAttendanceData();
                                    });
                                  },
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.group_off , color: Colors.red, size: 28,),
                                      Text(AppLocalizations.of(context)!.absent_, style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold)),
                                    ],),
                                ),
                                TextButton(
                                  onPressed: () {
                                    var attendance = jsonEncode({
                                      'event_id' : widget.eventId,
                                      'status' : 'permitted',
                                      'user_id' : userattendance['user_id']
                                    });
                                    var response = ApiService.addAttendance(attendance);
                                    setState(() {
                                      status = "Permitted";
                                      getAttendanceData();
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.done_all , color: Colors.orange, size: 28,),
                                      Text(AppLocalizations.of(context)!.permit_ , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold)),
                                    ],),
                                ),
                              ],
                            ),
                            trailing:
                            statusActions[userattendance['status']]?.call() ?? Container(
                                  child:
                                  const Icon(Icons.add , color: Colors.blue,)
                              ) ,
                      )) : Container();
                    },
                  );
                }else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
