import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/event_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/custom_dropdown.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  final bool isEditEvent;

  final EventResponse? data;

  CreateEvent({Key? key, required this.isEditEvent, this.data});

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends StatefulBasePage<CreateEvent> {
  _CreateEventState() : super(showHamburgerMenu: false,currentIndex: 3);

  String? dropdownValue;

  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Map containing the details from the login form.
  final Map<String, String> _createEventData = {
    'name': '',
    'numberOfParticipants': '',
    'countryCode': '',
    'eventTypeId': '53be8c61-0afe-48ee-9974-b09c1643bcca',
    'ageGroup': '',
    'location': '',
    'startDate': '',
    'endDate': '',
    'description': '',
    'userId': 'b8ad1ffe-a2ee-4f39-a5db-232fe9abf9ef',
    'isPrivate': 'false'
  };

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          ),
          UiHelper.getTextField(
            labelText: "Event Name",
            hintText: "Please Enter Event Name",
            validatorMessage: 'Please enter Event Name',
            dataForm: _createEventData,
            formKey: 'name',
            validate: true,
            initValue: widget.data?.name,
          ),
          /*CustomDropdown(
              label: 'Event Type',
              dropdownLabel: 'Choose',
              dropdownItems: _getEventTypes(),
              validate: true,
              dataForm: _createEventData,
              formKey: 'eventTypeId',
              initValue: widget.data?.eventTypeId,
          ),*/
          UiHelper.getTextField(
              labelText: "Number of Participants",
              hintText: "Please Enter a Number",
              validatorMessage: 'Please enter Number',
              dataForm: _createEventData,
              formKey: 'numberOfParticipants',
              validate: false,
              initValue: widget.data?.numberOfParticipants.toString()),
          CustomDropdown(
            label: 'Country',
            dropdownLabel: 'Choose',
            dropdownItems: _getCountries(),
            validate: true,
            dataForm: _createEventData,
            formKey: 'countryCode',
            initValue: widget.data?.countryCode,
          ),
          CustomDropdown(
            label: 'Age Group',
            dropdownLabel: 'Choose',
            dropdownItems: _getAgeGroup(),
            validate: true,
            dataForm: _createEventData,
            formKey: 'ageGroup',
            initValue: widget.data?.ageGroup,
          ),
          UiHelper.getTextField(
              labelText: "Destination",
              hintText: "Please Enter your Event Destination",
              validatorMessage: 'Please enter Destination',
              dataForm: _createEventData,
              formKey: 'location',
              validate: true,
              initValue: widget.data?.location),
          getDatePicker(
              label: 'Start DateTime',
              dataForm: _createEventData,
              formKey: "startDate",
              date: widget.data?.startDate),
          getDatePicker(
              label: 'End DateTime',
              dataForm: _createEventData,
              formKey: "endDate",
              date: widget.data?.endDate),
          UiHelper.getDescriptionFieldWithValidation(
              label: 'Description',
              validationText: 'Please Enter Description',
              formKey: 'description',
              dataForm: _createEventData),
          //UiHelper.buildButtonDefault(buttonText: 'Create', onPressedFunc: ()=>_onCreatePress())
          CustomButton(
              buttonText: (widget.data!=null)?'Update':'Create',
              onPressedFunc: () => _onCreatePress(),
              buttonType: ButtonType.OUTLINE)
        ],
      ),
    ));
  }

  Future<void> _onCreatePress() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    AuthenticationTokenProvider tokenProvider =
        Provider.of<AuthenticationTokenProvider>(context, listen: false);

    EventService service = EventService();

    try {
      String? authenticationToken = await tokenProvider.getBearerToken();
      if (authenticationToken != null) {
        EventResponse response =
            await service.createEvent(authenticationToken, _createEventData);
        UiHelper.showSnackBar(
            context: context, message: "Successfully created an Event");

        /// clears form data.
        _formKey.currentState?.reset();
      } else {
        return Future.error(
            "Error loading authentication token. Please log in again.");
      }
      //Navigator.of(context).pushReplacementNamed(RoutesName.ROUTE_LOGIN);
    } catch (error) {
      UiHelper.showErrorDialog(
          context: context, header: 'Error!!', message: error.toString());
    }
  }

  List<String> _getEventTypes() {
    List<String> eventTypes = <String>[
      'Seminar',
      'Conference',
      'Hiking',
      'Trekking',
      'Tour',
      'Party',
      'Gathering'
    ];
    return eventTypes;
  }

  List<String> _getCountries() {
    List<String> countries = <String>[
      'Nepal',
      'India',
      'Pakistan',
      'Srilanka',
      'Japan',
      'South Korea',
      'Indonesia',
      'USA',
      'Mexico'
    ];
    return countries;
  }

  List<String> _getAgeGroup() {
    List<String> ageGroup = <String>[
      'All',
      '< 15',
      '15-25',
      '25-45',
    ];
    return ageGroup;
  }

  Widget getDatePicker(
      {required String label,
      required Map<String, String> dataForm,
      required String formKey,
      DateTime? date}) {
    final firstDate = DateTime(DateTime.now().year - 120);
    final lastDate = DateTime.now();
    final format = DateFormat("yyyy-MM-dd HH:mm");

    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: DateTimeField(
          initialValue: date,
          decoration: InputDecoration(
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding: EdgeInsets.all(20),
          ),
          onSaved: (value) {
            dataForm[formKey] = value!.toIso8601String();
          },
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
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
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
        ));
  }

  @override
  String getTitle(BuildContext context) {
    return "My Events";
  }
}
