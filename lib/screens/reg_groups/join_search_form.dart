import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/Helpers/api_services.dart';
import 'package:jumuiya_app/screens/bottom_nav.dart';
import 'package:jumuiya_app/util/app_colors.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:masked_text_field/masked_text_field.dart';

import '../../models/group.dart';
import '../../util/constants.dart';
import '../../widgets/custom_button.dart';

class JoinSearchForm extends StatefulWidget {
  const JoinSearchForm({Key? key}) : super(key: key);

  @override
  State<JoinSearchForm> createState() => _JoinSearchFormState();
}

class _JoinSearchFormState extends State<JoinSearchForm> with TickerProviderStateMixin {
  final TextEditingController _groupIdentityController = TextEditingController();
  final List<Group> _groups = [];
  var groupDetail ;
  String errorResponse = '';
  String searchTerm = '';


  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  void _fetchGroups() async {
    print('init');
    final response = await ApiService.getPublicGroups();

    final groups = response;

      setState(() {
        _groups.clear();
        if(response == 'fail'){
          errorResponse = 'Something went wrong /Fail to get groups';
        }else{
          _groups.addAll(groups.cast<Group>());
        }
      });
  }

   _searchGroup(String groupNumber) async {
    print(groupNumber);
    final response = await ApiService.getSearchGroup(groupNumber);

    if(response == 'failed'){
        groupDetail = Group(id: 0, group_name: '0', group_number: '', created_at: '', created_by: 0, updated_at: '');
        return 'Something went wrong ! Failed';
    }else if (response == 'data_not_found'){
      groupDetail = Group(id: 0, group_name: '0', group_number: '', created_at: '', created_by: 0, updated_at: '');
        return 'Group Number Not Found';
    }else{
      setState(() {
        print('in group');
        groupDetail = response;
      });
      return 'ok';
    }
  }

  void _joinGroup(int groupId) async {
    final response = await ApiService.joinGroup( '1',groupId);
    if(response == 'failed'){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to Join'),
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        },
      );
    }else{
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Request sent Successfully'),
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()));
                  },
                ),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    showLoaderDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 10),child: const Text('Searching..')),
          ],),
      );

      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }
    showJoinGroupLoader(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 10),child: const Text('Send Request..')),
          ],),
      );

      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }

    void groupDetailsBottomSheet(context){
      showModalBottomSheet(context: context, builder: (BuildContext bc){
          return Container(
            height: MediaQuery.of(context).size.height * 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(groupDetail.group_name , style: Styles.headLineStyle1,),
                ),
                Text('Group Number: '+ groupDetail.group_number),
                Text('Group Location:' + groupDetail.group_location.toString()),
                Text('Description:' + groupDetail.description.toString()),
                Text('Number of Members: ' + json.decode(groupDetail.members.toString()).length.toString() ),
                CustomButton(
                    title: 'Send Join Request',
                    onTap: () {
                      showJoinGroupLoader(context);
                      _joinGroup(groupDetail.id);
                    },
                )
              ],
            ),
          );
      });
    }

    return  Column(
      children: [
        const Gap(30),
        Padding(padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
          child : MaskedTextField(
          textFieldController: _groupIdentityController,
          inputDecoration:  AppConstants.inputDecorationGroupID.copyWith(
          labelText: 'GROUP IDENTITY',
          hintText: 'XXXX-XXXX-XXXX', counterText: "",
            suffixIcon: CustomButton(
              onTap: () async {
                // showLoaderDialog(context);

                 var data = await  _searchGroup(_groupIdentityController.value.text);
                 if(data == 'ok'){
                   groupDetailsBottomSheet(context);
                 }else{
                   showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         title: Text(data.toString()),
                         actions: [
                           Align(
                             alignment: Alignment.center,
                             child: TextButton(
                               child: Text('OK'),
                               onPressed: () {
                                 Navigator.pop(context);
                               },
                             ),
                           )
                         ],
                       );
                     },
                   );
                 }
              },
              title: "join",
            ),
          ),
          mask: 'xxxx-xxxx-xxxx',
          maxLength: 14,
              onChange: (String value) {
                setState(() {
                  value = value.toUpperCase();
                });
              }
          )
        ),
        const Gap(15),
        Padding(
          padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
          child: TextFormField(
            scrollPadding: EdgeInsets.only(bottom:100),
            decoration:  AppConstants.inputDecorationForms.copyWith(
              hintText: 'Filter Search',
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
        Center(
          child: Text(errorResponse , style: TextStyle(color: Colors.red),),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _groups.length,
            itemBuilder: (context, index) {
              final group = _groups[index];
              return  group.group_name.toLowerCase().contains(searchTerm.toLowerCase()) ? Material(
                shadowColor: Colors.black12,
                elevation: 2.0,
                child: Padding(
                    padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
                    child: ListTile(
                    leading: const Icon(Icons.groups ,  size: 40 , color: Color(0xFF403FAD),),
                    title: Text(group.group_name),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(group.group_number),
                        Text(group.group_location.toString()),
                      ],
                    ),
                    trailing: IconButton(
                      color: AppColors.primary_bg_border,
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          groupDetail = group;
                          groupDetailsBottomSheet(context);

                        });
                      },
                    ),
                    tileColor: AppColors.barBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ) : Container();
            },
          ),
        ),
      ],
    );
  }
}
