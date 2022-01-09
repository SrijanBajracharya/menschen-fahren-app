import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/widgets/components/custom_alert.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/date_format_helper.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class EventDescription extends StatefulWidget {

  final EventResponse data;

  EventDescription({Key? key, required this.data}) : super(key: key);

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends StatefulBasePage<EventDescription> {
  _EventDescriptionState() : super(true);

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
                        UiHelper.buildDescriptionBlock(descText: widget.data.description),

                        UiHelper.buildDivider(),
                        UiHelper.buildTitle(title: 'Trip Info'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.buildIconInfo(FontAwesomeIcons.calendar, null, widget.data.eventType.name),
                            UiHelper.buildIconInfo(FontAwesomeIcons.users,null,widget.data.numberOfParticipants.toString()),
                          ],
                        ),
                        UiHelper.buildIconInfo(FontAwesomeIcons.calendarAlt, null, '${DateHelper.formatDate(widget.data.startDate)} - ${DateHelper.formatDate(widget.data.endDate)}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.buildIconInfo(FontAwesomeIcons.mapMarked, null, '${widget.data.location}' + ', ${widget.data.countryCode}'),
                          ],
                        ),
                        UiHelper.buildDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(buttonText: 'Edit', onPressedFunc: ()=>editButtonFunc(), buttonType: ButtonType.TEXT),
                            CustomButton(buttonText: 'Invite', onPressedFunc: ()=>
                                UiHelper.showYesNoDialogWithContent(context: context, title: 'Invite', content: UiHelper.getTextField("Invite Email", "Please Enter a Email", 'Please enter email', 'email',true), yesButtonText: 'Invite',
                                    noButtonText: 'Cancel', yesButtonOperation: ()=>inviteButtonFunc(), noButtonOperation: ()=>{}),
                                buttonType: ButtonType.TEXT),
                            CustomButton(buttonText: 'Request To Join', onPressedFunc: ()=>joinButtonFunc(), buttonType: ButtonType.TEXT),
                          ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  //Positioned
                ], //<Widget>[]
              ), //Stack
            )
        )
    );

  }

  void editButtonFunc(){

  }

  void inviteButtonFunc(){

  }

  void joinButtonFunc(){

  }









  @override
  String getTitle(BuildContext context) {
    return "Event Detail";
  }
}
