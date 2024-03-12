
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/elections/add_options_page.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import '../../util/app_colors.dart';
import '../../util/app_layouts.dart';
import '../../util/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/date_time_selector.dart';

class CreateElectionPage extends StatefulWidget {
  const CreateElectionPage({super.key});

  @override
  State<CreateElectionPage> createState() => _CreateElectionPageState();
}

class _CreateElectionPageState extends State<CreateElectionPage> {

  DateTime? _endTime;
  String _title = "";
  String _description = "";
  String _selectedValue = "";

  final GlobalKey<FormState> _form = GlobalKey();
  late TextEditingController _deadlineDateController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deadlineDateController = TextEditingController();
  }

  void _createElection() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    _resetForm();
  }

  void _resetForm() {

  }
  var electionData ;

  Future<void> _getElection() async {
    List<dynamic> list = [{ 'id'  : 1 , 'title' : 'Uchanguzi1hgvjhfhjfjhfhfhfjhfjhfhf' , 'end_date' : '2024-02-01' , 'election_type' : 'Viongozi' , 'status' : 'pending' , 'created_by' : 'Juma Hassan'} , { 'id'  : 1 , 'title' : 'Uchanguzi1' , 'end_date' : '2024-02-01' , 'election_type' : 'Other Election' ,  'status' : 'pending', 'created_by' : 'Juma Hassan'} , { 'id'  : 1 , 'title' : 'Uchanguzi1' , 'end_date' : '2024-02-01' , 'election_type' : 'Viongozi' , 'status' : 'closed' , 'created_by' : 'Musa Hassan'}  , { 'id'  : 1 , 'title' : 'Uchanguzi1' , 'end_date' : '2024-02-01' , 'election_type' : 'Viongozi' , 'status' : 'active' , 'created_by' : 'Juma Hassan'} ];
    electionData = list;
  }

  @override
  Widget build(BuildContext context) {
    List<String> _election_type = [AppLocalizations.of(context)!.group_leadership, AppLocalizations.of(context)!.other_election];
    _selectedValue = _election_type.first;

    final size  = AppLayouts.getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.election_and_votes),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.welcome_to_polling_station , style: Styles.headLineStyle6,),
              const Gap(10),
              Text(AppLocalizations.of(context)!.create_new_election),
              Container(
                width: size.width,
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: AppConstants.inputDecoration.copyWith(
                          labelText: AppLocalizations.of(context)!.election_title,
                        ),
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 17.0,
                        ),
                        onSaved: (value) => _title = value?.trim() ?? "",
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please enter election title.";
                          }
                          if(value.length >= 50){
                            return "Election Title must be less than 50 char.";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: DateTimeSelectorFormField(
                              controller: _deadlineDateController,
                              decoration: AppConstants.inputDecoration.copyWith(
                                labelText: AppLocalizations.of(context)!.election_deadline,
                              ),
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please select date.";
                                }

                                return null;
                              },
                              textStyle: const TextStyle(
                                color: AppColors.black,
                                fontSize: 17.0,
                              ),
                              onSave: (date) => _endTime = date,
                              type: DateTimeSelectionType.date,
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: AppConstants.inputDecorationGroupType.copyWith(
                                labelText: AppLocalizations.of(context)!.election_type,
                              ),
                              value: _selectedValue,
                              hint: Text(AppLocalizations.of(context)!.election_type),
                              items: _election_type.map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value.toString();
                                });// Notify the Form about the change
                              },
                            ),
                          ),
                      ]),
                      const Gap(15),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        onTap: _createElection,
                        title: "Add Election",
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              FutureBuilder(future: _getElection() , builder: (context , election) {
                return Container(
                  height: size.height * 0.4,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: electionData.length ,
                    itemBuilder: (context ,index) {
                      return ListTile(
                        onTap: (){
                          print('0i');
                        },
                        title: Text(electionData[index]['title'] , overflow: TextOverflow.ellipsis),
                        subtitle: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.status + ": " + electionData[index]['status']),
                            const Gap(5),
                            Text(AppLocalizations.of(context)!.end + ": " + electionData[index]['end_date'])
                          ],
                        ),
                        trailing: GestureDetector(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  AppOptionsPage(electionData[index])),
                           );
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
                            child: Text(AppLocalizations.of(context)!.option , style:  TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                            ),),
                          ),
                        ),
                      );
                    } ,
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
