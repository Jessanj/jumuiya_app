import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:jumuiya_app/Helpers/api_services.dart';
import 'package:jumuiya_app/util/extensions.dart';
import '../models/event.dart';
import '../util/app_colors.dart';
import '../util/constants.dart';
import 'custom_button.dart';
import 'date_time_selector.dart';

class AddEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;

  const AddEventWidget({
    Key? key,
    this.onEventAdd,
  }) : super(key: key);

  @override
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  late DateTime _startDate;
  late DateTime _endDate;

  DateTime? _startTime;
  DateTime? _endTime;
  String _title = "";
  String _description = "";
  String _location = "";

  Color _color = Colors.blue;

  late FocusNode _titleNode;
  late FocusNode _descriptionNode;
  late FocusNode _locationNode;
  late FocusNode _dateNode;

  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _endDateController;
  bool isRecurring  = false;

  @override
  void initState() {
    super.initState();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();
    _dateNode = FocusNode();
    _locationNode = FocusNode();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _descriptionNode.dispose();
    _dateNode.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _locationNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      scrollDirection: Axis.vertical,
      children:[
      Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: AppConstants.inputDecoration.copyWith(
              labelText: "Event Title",
            ),
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            onSaved: (value) => _title = value?.trim() ?? "",
            validator: (value) {
              if (value == null || value == "") {
                return "Please enter event title.";
              }
              if(value.length >= 50){
                return "Event Title must be less than 50 char.";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: DateTimeSelectorFormField(
                  controller: _startDateController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "Start Date",
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
                  onSave: (date) => _startDate = date,
                  type: DateTimeSelectionType.date,
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: DateTimeSelectorFormField(
                  controller: _endDateController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "End Date",
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
                  onSave: (date) => _endDate = date,
                  type: DateTimeSelectionType.date,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: DateTimeSelectorFormField(
                  controller: _startTimeController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "Start Time",
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Please select start time.";
                    }

                    return null;
                  },
                  onSave: (date) => _startTime = date,
                  textStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),
                  type: DateTimeSelectionType.time,
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: DateTimeSelectorFormField(
                  controller: _endTimeController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "End Time",
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Please select end time.";
                    }

                    return null;
                  },
                  onSave: (date) => _endTime = date,
                  textStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),
                  type: DateTimeSelectionType.time,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextFormField(
            focusNode: _locationNode,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            selectionControls: MaterialTextSelectionControls(),
            minLines: 1,
            validator: (value) {
              if (value == null || value.trim() == "") {
                return "Please enter event location.";
              }

              return null;
            },
            onSaved: (value) => _location  = value?.trim() ?? "",
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: "Event Location",
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextFormField(
            focusNode: _descriptionNode,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            selectionControls: MaterialTextSelectionControls(),
            minLines: 1,
            maxLines: 4,
            maxLength: 360,
            validator: (value) {
              if (value == null || value.trim() == "") {
                return "Please enter event description.";
              }

              return null;
            },
            onSaved: (value) => _description = value?.trim() ?? "",
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: "Event Description",
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),

          Row(
            children: [
              const Text(
                "Is Recurring: ",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 17,
                ),
              ),
              Switch(
                // This bool value toggles the switch.
                value: isRecurring,
                activeColor: AppColors.navyBlue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    isRecurring = value;
                    print(isRecurring);
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onTap: _createEvent,
            title: "Add Event",
          ),
        ],
      ),
    ),
      ]);
  }

  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final event = CalendarEventData<Event>(
      date: _startDate,
      color: _color,
      endTime: _endTime,
      startTime: _startTime,
      description: _description,
      endDate: _endDate,
      title: _title,
      event: Event(
        id: 0,
        title: _title,
        location : _location,
        isRecurring : isRecurring,
        startDate: _startDate.dateToStringWithFormat(),
        endDate : _endDate.dateToStringWithFormat(),
        description: _description,
        userId: 1,
      ),
    );

    final eventDetails = Event(
      id: 0,
      title: _title,
      location : _location,
      isRecurring : isRecurring,
      startDate: _startDate.dateToStringWithFormat(),
      endDate : _endDate.dateToStringWithFormat(),
      description: _description,
      userId: 1,
    ).toJson();

    ApiService.addEvent(eventDetails);

    widget.onEventAdd?.call(event);
    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDateController.text = "";
    _endTimeController.text = "";
    _startTimeController.text = "";
  }

}