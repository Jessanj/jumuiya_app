import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jumuiya_app/models/user.dart';
import 'package:jumuiya_app/screens/users/edit_user_detail_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/api_services.dart';
import '../util/app_colors.dart';
import '../util/app_styles.dart';
import '../widgets/left_drawer.dart';
import 'member_detail.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  OverlayEntry ? overlayEntry ;
  var userData; var groupData;

  Future<void> _fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userData = await ApiService.getUser(prefs.getInt('userId'));
    groupData = await ApiService.getUserGroup(prefs.getInt('userId')!.toInt());
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
        title: Text(AppLocalizations.of(context)!.my_profile),
      ),
      drawer:  const Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: LeftDrawer(),
      ),
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
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 60),
                                  child: Text(capitalizeFirst(userData[0]['first_name']) +' '+ capitalizeFirst(userData[0]['middle_name'].toString()) +' '+ capitalizeFirst(userData[0]['last_name']), style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold  ),)
                              ),
                              Text(userData[0]['email'].toLowerCase()),
                              const Gap(15),
                              groupData == 'no_group' ? Column(
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
                                        child: Text(AppLocalizations.of(context)!.total_attendance , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        alignment: Alignment.center,
                                        child: Text(AppLocalizations.of(context)!.total_contribution , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black),),
                                      ),
                                    ],
                                  )
                                ],
                              ) :
                              groupData[0].group_type == 'Private' ? Column(
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
                                        child: Text('1000' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.white),),
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
                                        child: Text('10' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        alignment: Alignment.center,
                                        width: 100,
                                        child: Text('Balance' , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black38),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 50),
                                        alignment: Alignment.center,
                                        width: 100,
                                        child: Text('Shares' , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black38),),
                                      ),
                                    ],
                                  )
                                ],
                              ) :
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
                            child: userData[0]['profile_image'].toString() == 'null' ? CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatorProfile.png'),
                              maxRadius: 60,
                            ) :
                            CircleAvatar(
                              backgroundImage: NetworkImage(userData[0]['profile_image'].toString()),
                              maxRadius: 60,
                            )
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 30,
                        child: ElevatedButton(onPressed: () {
                          print(userData[0]['id']);
                          UserModel newData = UserModel(id: userData[0]['id'], first_name: userData[0]['first_name'], middle_name: userData[0]['middle_name'], last_name: userData[0]['last_name'], email: userData[0]['email'], address: userData[0]['address'], phone: userData[0]['phone'] , nida : userData[0]['nida'] , date_joined: userData[0]['date_joined'] , profile_image: userData[0]['profile_image']);
                          print(newData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  EditUserDetailPage(newData)),
                          );
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
                        color: AppColors.lightNavyBlue,
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
                              Text(userData[0]['phone'] , style: Styles.headLineStyle6)
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NIN' , style: Styles.headLineStyle6,),
                              Gap(30),
                              Text(userData[0]['nida'] , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
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
                              Text(userData[0]['address'] , style: Styles.headLineStyle6 , textAlign: TextAlign.start,),
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
                              Text(get_date_from_string(DateTime.parse(userData[0]['date_joined'].toString()), 'd MMM yyyy') , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
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
                        color: AppColors.lightNavyBlue,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: groupData == 'no_group'? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(AppLocalizations.of(context)!.group_information, style: Styles.headLineStyle2 ),
                            )
                          ],
                        ),
                        const Gap(20),
                        Center(
                          child: Text(AppLocalizations.of(context)!.no_group_attached , style: Styles.headLineStyle5  , textAlign: TextAlign.center,),
                        )
                      ],
                    ) : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(AppLocalizations.of(context)!.group_information, style: Styles.headLineStyle2 ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.name + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text( capitalizeFirst(groupData[0].group_name) , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.group_type + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text(groupData[0].group_type , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.group_number + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text( groupData[0].group_number, style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.location + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text(groupData[0].group_location, style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.members + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text( groupData[0].members.length.toString() , style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20 , top: 5 , right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.created_date + " :", style: Styles.headLineStyle6,),
                              Gap(30),
                              Expanded(child:
                              Text( get_date_from_string(DateTime.parse(groupData[0].created_at.toString()), 'd MMM yyyy'), style: Styles.headLineStyle6 , textAlign: TextAlign.start,)
                              )
                            ],
                          ),
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: (){

                                },
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  height: 25,
                                  width: 100,
                                  child: Text(AppLocalizations.of(context)!.more_details , style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                )
                            ),
                            Gap(20)
                          ],
                        )
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
