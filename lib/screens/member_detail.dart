import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jumuiya_app/models/attendance.dart';
import 'package:jumuiya_app/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jumuiya_app/screens/users/edit_user_detail_page.dart';

import '../util/app_colors.dart';
import '../util/app_layouts.dart';
import '../util/app_styles.dart';
import '../widgets/left_drawer.dart';

class MemberDetail extends StatefulWidget {
  final UserModel userData;
  const MemberDetail(this.userData);

  @override
  State<MemberDetail> createState() => _MemberDetailState();
}

class _MemberDetailState extends State<MemberDetail> {

  late var AttendanceData;

  Future<void> _fetchData() async{

  }
  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    String capitalizeFirst(String text) => text.length > 0 ? text[0].toUpperCase() + text.substring(1) : '';
    String get_date_from_string(DateTime parseDate , String format) {
      // Define the date format string.
      String date_format = format;
      // Create a DateFormat object with the date format string.
      String data  = DateFormat(date_format).format(parseDate).toString();
      // Return the date.
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title:  Text(AppLocalizations.of(context)!.members_details),
      ),
      //
      // drawer:  const Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: LeftDrawer(),
      // ),
      body:  FutureBuilder(future: _fetchData(), builder:(context , snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default :
            if(snapshot.hasError){
              return Text('Error: ${snapshot.error}' , style: TextStyle(color: Colors.red),);
            }else{
              return ListView(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          width: size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 60),
                                  child: Text(capitalizeFirst(widget.userData.first_name.toString()) +' '+ capitalizeFirst(widget.userData.middle_name.toString()) +' '+ capitalizeFirst(widget.userData.last_name), style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold  ),)
                              ),
                              Text(widget.userData.email.toLowerCase()),
                              const Gap(15),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text('0' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.white),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 50),
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text('0' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 30),
                                        alignment: Alignment.center,
                                        child: Text(AppLocalizations.of(context)!.total_attendance , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black38),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        alignment: Alignment.center,
                                        child: Text(AppLocalizations.of(context)!.total_contribution , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black38),),
                                      ),
                                    ],
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: size.width*0.4,
                        left: size.width*0.4,
                        top: 10,
                        child: Container(
                          width: 80,
                          height: 80,
                          child:
                          widget.userData.profile_image == 'null' ?
                          CircleAvatar(radius: 64, backgroundImage:  AssetImage('assets/images/avatorProfile.png')) :
                          CircleAvatar(radius: 64,
                              backgroundImage: NetworkImage(widget.userData.profile_image.toString()))
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 30,
                        child: ElevatedButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserDetailPage(widget.userData)));
                        },
                          style:ButtonStyle() ,
                          child: Text('Edit'),
                        ),
                      ),

                    ],
                  ),
                  const Gap(15),
                  Container(
                    height: 230,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(12),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(AppLocalizations.of(context)!.personal_information , style: Styles.headLineStyle2 ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.phone_number , style: Styles.headLineStyle6,textAlign: TextAlign.start),
                              Text(widget.userData.phone , style: Styles.headLineStyle6)
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NIN' , style: Styles.headLineStyle6,),
                              Gap(30),
                              Text(widget.userData.nida.toString() , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.home_address , style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text(widget.userData.address , style: Styles.headLineStyle6 , textAlign: TextAlign.start,),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.date_join + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text(get_date_from_string(DateTime.parse(widget.userData.date_joined.toString()), 'd MMM yyyy') , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.map_address , style: Styles.headLineStyle6,),
                              Gap(30),
                              Row(
                                children: [
                                  Text( "Available " , style: TextStyle(color: Colors.green , fontWeight: FontWeight.bold , fontSize: 18) , textAlign: TextAlign.start,),
                                  Text("GoTo" , style: Styles.headLineStyle6,),
                                  Icon(Icons.location_on),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(15),
                  Container(
                    height: 260,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(AppLocalizations.of(context)!.attendance_info, style: Styles.headLineStyle2 ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Container(
                    height: 260,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(AppLocalizations.of(context)!.contribution_details, style: Styles.headLineStyle2 ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
        }
      }
      ),
    );
  }
}
