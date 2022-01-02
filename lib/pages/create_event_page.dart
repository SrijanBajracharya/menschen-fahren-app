import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/custom_dropdown.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class CreateEvent extends StatefulWidget {

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends StatefulBasePage<CreateEvent> {

  _CreateEventState() : super(true);

  String? dropdownValue;

  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Map containing the details from the login form.
  final Map<String, String> _createEventData = {
    'email': '',
    'password': '',
    'descText':''
  };

  Future<void> _pressedLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            UiHelper.getTextField("Event Name", "Please Enter Event Name", 'Please enter Event Name', 'eventName',true),
            CustomDropdown(label: 'Event Type', dropdownLabel: 'Choose', dropdownItems: _getEventTypes(),validate: true,),
            UiHelper.getTextField("Number of Participants", "Please Enter a Number", 'Please enter Number', 'noOfParticipants',false),
            CustomDropdown(label: 'Country', dropdownLabel: 'Choose', dropdownItems: _getCountries(),validate: true,),
            UiHelper.getTextField("Destination", "Please Enter your Event Destination", 'Please enter Destination', 'destination',true),
            getDatePicker(label: 'Start DateTime'),
            getDatePicker(label: 'End DateTime'),
            UiHelper.getDescriptionFieldWithValidation(label: 'Description',validationText: 'Please Enter Description', formKey: _createEventData['descText']!),
            //UiHelper.buildButtonDefault(buttonText: 'Create', onPressedFunc: ()=>_onCreatePress())
            CustomButton(buttonText: 'Create', onPressedFunc: ()=>_onCreatePress(), buttonType: ButtonType.TEXT)
          ],
        ),
      )
    );
  }

  void _onCreatePress(){
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
  }

  List<String> _getEventTypes(){
    List<String> eventTypes = <String>['Seminar','Conference','Hiking','Trekking','Tour','Party','Gathering'];
    return eventTypes;
  }

  List<String> _getCountries(){
    List<String> countries = <String>['Nepal','India','Pakistan','Srilanka','Japan','South Korea','Indonesia','USA', 'Mexico','Nepal','India','Pakistan','Srilanka','Japan','South Korea','Indonesia','USA', 'Mexico'];
    return countries;
  }

  Widget getDatePicker({required String label}) {
    final firstDate = DateTime(DateTime
        .now()
        .year - 120);
    final lastDate = DateTime.now();
    final format = DateFormat("yyyy-MM-dd HH:mm");

    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: DateTimeField(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)),
            contentPadding: EdgeInsets.all(20),
          ),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: DateTime.now(),
              lastDate: DateTime(2100),
              builder: (context, child) =>
                  Localizations.override(
                    context: context,
                    child: child,
                  ),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                    currentValue ?? DateTime.now()),
                builder: (context, child) =>
                    Localizations.override(
                      context: context,
                      child: child,
                    ),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        )
    );
  }

  @override
  String getTitle(BuildContext context) {
    return "My Events";
  }
}
