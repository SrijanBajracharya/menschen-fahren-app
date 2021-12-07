import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends StatefulBasePage<CreateEvent> {

  _CreateEventState() : super(true);

  String? dropdownValue;

  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Map containing the details from the login form.
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
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
            getDropdown('Event Type',() =>getEventTypeDropdown()),
            getDropdown('Country',()=>getCountryDropdown()),
            getTextField("Destination", "Please Enter your Event Destination", 'Please enter Destination', 'destination'),
            getDatePicker('startDate'),
            getDescriptionField(),
            Center(
              child: OutlinedButton(
                onPressed: () => _pressedLogin(context),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff8BBA50),
                    minimumSize: const Size(100, 50),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 80
                    )
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget getDescriptionField(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:TextFormField(
        decoration: InputDecoration(
          labelText: 'Description',
          hintText: "Enter your text here",
          border: const OutlineInputBorder()
        ),
        minLines: 1,
        maxLines: 4,
      ),
    );
  }
  
  Widget getTextField(String labelText, String hintText, String validatorMessage, String formKey){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              // controller: passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                  hintText: hintText
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validatorMessage;
                }
                return null;
              },
              onSaved: (value) {
                _authData[formKey] = value!;
              },
            ),
          ],
        )
    );
  }

  Widget getDropdown(String labelName,Function callFunction){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelName,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.all(5),
        ),
        child: callFunction.call(),
      ),
    );
  }

  Widget getDatePicker(String formKey) {
    final firstDate = DateTime(DateTime.now().year - 120);
    final lastDate = DateTime.now();
    final format = DateFormat("yyyy-MM-dd HH:mm");

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: DateTimeField(
          decoration: InputDecoration(
            labelText: 'Event Date',
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
              builder: (context, child) => Localizations.override(
                context: context,
                child: child,
              ),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                builder: (context, child) => Localizations.override(
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


  Widget getEventTypeDropdown(){
    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      child: DropdownButton<String>(
        hint: const Text("Priority"),
        isExpanded: true,
        value: dropdownValue,
        elevation: 16,
        underline: DropdownButtonHideUnderline(
          child: Container(),
        ),
        onChanged: (String? newValue) {
          _authData['eventType'] = newValue!;
        },
        items: <String>['Red', 'Green', 'Blue']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget getCountryDropdown(){
    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      child: DropdownButton<String>(
        hint: const Text("Country"),
        isExpanded: true,
        value: dropdownValue,
        elevation: 16,
        underline: DropdownButtonHideUnderline(
          child: Container(),
        ),
        onChanged: (String? newValue) {
          _authData['country'] = newValue!;
        },
        items: <String>['Red', 'Green', 'Blue']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  @override
  String getTitle(BuildContext context) {
    return "My Events";
  }
}
