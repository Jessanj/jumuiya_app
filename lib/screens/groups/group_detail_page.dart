import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jumuiya_app/Helpers/api_services.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:jumuiya_app/util/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_colors.dart';
import '../../util/app_layouts.dart';

class GroupDetailPage extends StatefulWidget {
  const GroupDetailPage({super.key});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  var groupData;
  var groupLeader;

  Future<void> _fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    groupData = await ApiService.getUserGroup(prefs.getInt('userId')!.toInt());
    groupLeader =
        await ApiService.getGroupLeader(prefs.getInt('userId')!.toString());
  }

  // Future _fetchLeader() async {
  //   var response;
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   response = await ApiService.getGroupLeader(prefs.getInt('userId')!.toString());
  //   return response;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String get_date_from_string(DateTime parseDate, String format) {
    // Define the date format string.
    String date_format = format;
    // Create a DateFormat object with the date format string.
    String data = DateFormat(date_format).format(parseDate).toString();

    // Return the date.
    return data;
  }

  String capitalizeFirst(String text) =>
      text.length > 0 ? text[0].toUpperCase() + text.substring(1) : '';

  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Text(AppLocalizations.of(context)!.group_information),
      ),
      body: FutureBuilder(
          future: _fetchData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(10),
                        groupData.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .no_group_attached,
                                      style: Styles.headLineStyle1,
                                    ),
                                    const Gap(20),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.primary),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(8.0)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                                .getStarted +
                                            ' ' +
                                            AppLocalizations.of(context)!
                                                .join_group,
                                        style: Styles.headLineStyle2w,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                height: 320,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.lightNavyBlue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: groupData.toString() == 'no_group'
                                    ? Column(
                                        children: [
                                          const Gap(20),
                                          Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .no_group_attached,
                                              style: Styles.headLineStyle5,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .name +
                                                      " :",
                                                  style: Styles.headLineStyle6,
                                                ),
                                                Gap(10),
                                                Expanded(
                                                    child: Text(
                                                  capitalizeFirst(
                                                      groupData[0].group_name),
                                                  style: Styles.headLineStyle6,
                                                  textAlign: TextAlign.start,
                                                ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .group_type +
                                                      " :",
                                                  style: Styles.headLineStyle6,
                                                ),
                                                Gap(30),
                                                Expanded(
                                                    child: Text(
                                                  groupData[0].group_type,
                                                  style: Styles.headLineStyle6,
                                                  textAlign: TextAlign.start,
                                                ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .group_number +
                                                      " :",
                                                  style: Styles.headLineStyle6,
                                                ),
                                                Gap(30),
                                                Expanded(
                                                    child: Text(
                                                  groupData[0].group_number,
                                                  style: Styles.headLineStyle6,
                                                  textAlign: TextAlign.start,
                                                ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .location +
                                                      " :",
                                                  style: Styles.headLineStyle6,
                                                ),
                                                Gap(30),
                                                Expanded(
                                                    child: Text(
                                                  groupData[0].group_location,
                                                  style: Styles.headLineStyle6,
                                                  textAlign: TextAlign.start,
                                                ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .members +
                                                      " :",
                                                  style: Styles.headLineStyle6,
                                                ),
                                                Gap(30),
                                                Expanded(
                                                    child: Text(
                                                  groupData[0]
                                                      .members
                                                      .length
                                                      .toString(),
                                                  style: Styles.headLineStyle6,
                                                  textAlign: TextAlign.start,
                                                ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .created_date +
                                                      " :",
                                                  style: Styles.headLineStyle6,
                                                ),
                                                Gap(30),
                                                Expanded(
                                                    child: Text(
                                                  get_date_from_string(
                                                      DateTime.parse(
                                                          groupData[0]
                                                              .created_at
                                                              .toString()),
                                                      'd MMM yyyy'),
                                                  style: Styles.headLineStyle6,
                                                  textAlign: TextAlign.start,
                                                ))
                                              ],
                                            ),
                                          ),
                                          const Gap(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .description,
                                                style: Styles.headLineStyle6,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: 80,
                                              child: SingleChildScrollView(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Text(
                                                    groupData[0].description,
                                                    style:
                                                        Styles.headLineStyle7,
                                                  )))
                                        ],
                                      ),
                              ),
                        const Gap(10),

                       Container(
                                height: 230,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.lightNavyBlue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 2, right: 5, bottom: 10),
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .group_leadership,
                                              style: Styles.headLineStyle6,
                                            )
                                          ]),
                                      const Gap(10),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            width: size.width,
                                            height: 180,
                                            child: NestedScrollView(
                                              headerSliverBuilder: (context, innerChildOverscroll) => [],
                                              body: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount:  groupLeader.toString() == 'no_leader' ? 1 :groupLeader.length,
                                                itemBuilder: (context, index) {
                                                  if(groupLeader.toString() == 'no_leader') {
                                                    return  Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(context)!.no_group_leader,
                                                            style: Styles.headLineStyle1,
                                                          ),
                                                          const Gap(20),
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty.all<Color>(
                                                                  AppColors.primary),
                                                              padding: MaterialStateProperty.all<
                                                                  EdgeInsets>(EdgeInsets.all(8.0)),
                                                              shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10),
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(context)!
                                                                  .getStarted +
                                                                  ' ' +
                                                                  AppLocalizations.of(context)!
                                                                      .add_leaders,
                                                              style: Styles.headLineStyle2w,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }else {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            16.0), // Add padding inside the container
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8.0), // Apply rounded border
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              // Add a subtle shadow
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                  0.3),
                                                              blurRadius: 3.0,
                                                              offset:
                                                              Offset(2, 3),
                                                            )
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize
                                                              .min, // Keep column as small as possible
                                                          children: [
                                                            groupLeader[index]['user_data']['image'].toString() == 'null' ?
                                                            CircleAvatar(
                                                              radius:
                                                              30.0, // Set radius for the avatar
                                                              backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/avatorProfile.png'),
                                                              // Replace with your actual image URL or use AssetImage for local images
                                                            ) :
                                                            CircleAvatar(
                                                              radius:
                                                              30.0, // Set radius for the avatar
                                                              backgroundImage:
                                                              NetworkImage(groupLeader[index]['user_data']['image'].toString()),
                                                              // Replace with your actual image URL or use AssetImage for local images
                                                            ) ,
                                                            const Gap(5),
                                                            Text(
                                                              groupLeader[index]['user_data']['name'].toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            const Gap(5),
                                                            Text(groupLeader[index]['user_data']['phone'].toString()), // Phone number
                                                            const Gap(5),
                                                            Text(groupLeader[index]['title']), // Job title or other title
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                },
                                              ),
                                            ),
                                          )),
                                    ]))),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
