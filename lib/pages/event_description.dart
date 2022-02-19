import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/models/notification_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/event_service.dart';
import 'package:project_menschen_fahren/providers/notification_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/custom_alert.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/date_format_helper.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:provider/provider.dart';

class EventDescription extends StatefulWidget {
  final EventResponse data;

  EventDescription({Key? key, required this.data}) : super(key: key);

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends StatefulBasePage<EventDescription> {
  _EventDescriptionState() : super(showHamburgerMenu: false,currentIndex: 0,showBackButton: true, routeBackTo: RoutesName.MAIN_PAGE);

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  final Map<String, String> _editEventData = {
    'aboutMe': '',
    'hobbies': '',
    'descText': ''
  };

  @override
  String getTitle(BuildContext context) {
    return "Event Detail";
  }

  @override
  Widget buildContent(BuildContext context) {

    return SingleChildScrollView(
        child: Center(
            child: Padding(
      padding: EdgeInsets.only(top: 0),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UiHelper.buildTitle(title: widget.data.name),
                UiHelper.buildDescriptionBlock(
                    descText: widget.data.description),
                UiHelper.buildDivider(),
                UiHelper.buildTitle(title: 'Trip Info'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UiHelper.buildIconInfo(FontAwesomeIcons.calendar, null,
                        widget.data.eventType.name),
                    UiHelper.buildIconInfo(FontAwesomeIcons.users, null,
                        widget.data.numberOfParticipants.toString()),
                  ],
                ),
                UiHelper.buildIconInfo(FontAwesomeIcons.calendarAlt, null,
                    '${DateHelper.formatDate(widget.data.startDate)} - ${DateHelper.formatDate(widget.data.endDate)}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UiHelper.buildIconInfo(
                        FontAwesomeIcons.mapMarked,
                        null,
                        '${widget.data.location}' +
                            ', ${widget.data.country}'),
                  ],
                ),
                UiHelper.buildDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        buttonText: 'Edit',
                        onPressedFunc: () => editButtonFunc(widget.data),
                        buttonType: ButtonType.ELEVATED),
                    /*CustomButton(buttonText: 'Invite', onPressedFunc: ()=>
                                UiHelper.showYesNoDialogWithContent(context: context, title: 'Invite', content: UiHelper.getTextField("Invite Email", "Please Enter a Email", 'Please enter email',_editEventData, 'email',true), yesButtonText: 'Invite',
                                    noButtonText: 'Cancel', yesButtonOperation: ()=>inviteButtonFunc(), noButtonOperation: ()=>{}),
                                buttonType: ButtonType.TEXT),*/
                    CustomButton(
                        buttonText: 'Invite',
                        onPressedFunc: () => showDialogWithFields(),
                        buttonType: ButtonType.OUTLINE),
                    //CustomButton(buttonText: 'Request', onPressedFunc: ()=>joinButtonFunc(), buttonType: ButtonType.OUTLINE),
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          //Positioned
        ], //<Widget>[]
      ), //Stack
    )));
  }

  void editButtonFunc(EventResponse data) {
    Navigator.of(context)
        .pushReplacementNamed(RoutesName.CREATE_EVENT, arguments: data);
  }

  void inviteButtonFunc() {}

  void joinButtonFunc() {}

  void showDialogWithFields() {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Invite',
              style: TextStyle(fontFamily: Constants.PRIMARY_FONT_FAMILY),
            ),
            content: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value!)) {
                          return "Invalid email";
                        }
                        return null;
                      },
                      controller: emailController,
                      onSaved: (value) {
                        emailController.text = value??'';
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:20,bottom: 20),
                      child: Text('OR',),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'User',
                        icon: Icon(Icons.account_circle),
                      ),
                      controller: usernameController,
                      onSaved: (value) {
                        usernameController.text = value ?? '';
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              CustomButton(
                  buttonText: 'Invite',
                  onPressedFunc: () => _inviteFunc(),
                  buttonType: ButtonType.OUTLINE)
            ],
          );
        });
  }

  Future<void> _inviteFunc() async {
    if (emailController.text.isEmpty && usernameController.text.isEmpty) {
      return;
    }

    Map<String, String> _inviteData = {

      "receiverEmailId": emailController.text,
      "eventId": widget.data.id
    };

    AuthenticationTokenProvider tokenProvider =
    Provider.of<AuthenticationTokenProvider>(context, listen: false);

    NotificationService service = NotificationService();

    try {
      String? authenticationToken = await tokenProvider.getBearerToken();
      if (authenticationToken != null) {
        NotificationResponse response =
        await service.createNotification(authenticationToken, _inviteData);
        UiHelper.showSnackBar(
            context: context, message: "Successfully invited user to the event.");

        emailController.text = '';
        usernameController.text = '';
        Navigator.pop(context);

        /// clears form data.
        // _formKey.currentState?.reset();
      } else {
        return Future.error(
            "Error loading authentication token. Please log in again.");
      }
      //Navigator.of(context).pushReplacementNamed(RoutesName.ROUTE_LOGIN);
    } catch (error) {
      UiHelper.showErrorDialog(
          context: context, header: 'Error!!', message: error.toString());


      /* if (emailController.text ==null && usernameController.text == null) {
      // Invalid!
      return;
    }


    }*/
    }
  }

}
