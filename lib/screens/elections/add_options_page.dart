import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:jumuiya_app/util/app_styles.dart';

import '../../Helpers/api_services.dart';
import '../../util/app_colors.dart';
import '../../util/constants.dart';
import '../../widgets/custom_button.dart';

class AppOptionsPage extends StatefulWidget {
  final electionData;
  const AppOptionsPage(this.electionData, {super.key});

  @override
  State<AppOptionsPage> createState() => _AppOptionsPageState();
}

class _AppOptionsPageState extends State<AppOptionsPage> {

  Future fetchUsers() async {
    return ApiService.getGroupMembers(2);
  }

  Future fetchEletionOptions() async {
    var data = [{'id' : 1 , 'description' : 'Option1' , 'full_name' : 'juma hasani mussa' , 'user_id' : 1, 'phone' : '0298339202'} , {'id' : 1 , 'description' : 'Option1' , 'full_name' : 'juma hasani mussa' , 'user_id' : 1 , 'phone' : '0298339202'}];
    return data ;
  }
  void addOption(){

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  late TextEditingController _deadlineDateController;
  final focusNode = FocusNode();



  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.add_election_option),
        backgroundColor: AppColors.navyBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    children: [
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.electionData['title'] , style: Styles.headLineStyle6,)
                        ],
                      ),
                      const Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(AppLocalizations.of(context)!.status + ': '  + widget.electionData['status'] ),
                          Text(AppLocalizations.of(context)!.election_deadline + ': '  + widget.electionData['end_date'] )
                        ],
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(AppLocalizations.of(context)!.type + ': '  + widget.electionData['election_type'] ),
                          Text(AppLocalizations.of(context)!.election_deadline + ': '  + widget.electionData['end_date'] )
                        ],
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(AppLocalizations.of(context)!.created_by +": " +  widget.electionData['created_by'])
                        ],
                      ),
                      const Gap(5),

                    ],
                  )
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.election_options , style: Styles.headLineStyle6,),
                ],
              ),
              const Gap(10),
              widget.electionData['election_type'] == 'Other Election' ?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: TextField(
                      decoration: AppConstants.inputDecorationForms.copyWith(
                        labelText: AppLocalizations.of(context)!.option,
                      ),
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 17.0,
                      ),
                      onTapOutside: (PointerDownEvent event){
                        if (focusNode.hasFocus) {
                          focusNode.unfocus();
                        }
                      },
                      focusNode: focusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  const Gap(15),
                  GestureDetector(
                    onTap: (){
                      addOption();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.navyBlue,
                        borderRadius: BorderRadius.circular(7.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black,
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: -3,
                          )
                        ],
                      ),
                      child: Text("+ "+ AppLocalizations.of(context)!.add , style:  TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                      ),),
                    ),
                  )
                ],
              )
                  : const Gap(2),
              FutureBuilder(future: fetchEletionOptions()  , builder: (context , options) {
                print(widget.electionData);
                return Container(
                  height: size.height * 0.3,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: options.data.length, itemBuilder: (BuildContext context, int index) {
                    if(widget.electionData['election_type'] == 'Other Election')
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text((index+1).toString() +". "+ options.data[index]['description']),
                          TextButton(onPressed: (){
                          }, child: Icon(Icons.delete_forever)),
                        ],
                      );
                    else{
                      return   ListTile(
                        title: Text((index+1).toString() +". "+ options.data[index]['full_name']),
                        subtitle: Text(options.data[index]['phone']),
                      );
                    }
                  }),
                );
              }),
              widget.electionData['election_type'] == 'Other Elections' ? const Gap(10) :
              FutureBuilder(future: fetchUsers(), builder: (context , usersList){
                if(usersList.connectionState == ConnectionState.done){
                  if(usersList.hasData){
                    return Container(
                      height: size.height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: usersList.data.lenght,
                        itemBuilder: (BuildContext context, int index) {
                          return Text('iei');
                        },
                      ),
                    );
                  }else{
                    return Container(
                      child: Text('Group Have no Members'),
                    );
                  }

                }else{
                  return CircularProgressIndicator();
                }

              }),
            ],
          ),
        ),
      )
    );
  }
}
