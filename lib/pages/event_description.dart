import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class EventDescription extends StatefulWidget {
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
                        UiHelper.buildTitle(title: 'Pokhara Trip'),
                        UiHelper.buildDescriptionBlock(descText: "I am ambitious and driven. I thrive on challenge and constantly set goals for myself, so I have something to strive toward. I am not comfortable with settling, and I am always looking for an opportunity to do better and achieve greatness. In my previous role, I was promoted three times in less than two years."),

                        UiHelper.buildDivider(),
                        UiHelper.buildTitle(title: 'Trip Info'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.buildIconInfo(FontAwesomeIcons.calendar, null, 'Trek'),
                            UiHelper.buildIconInfo(FontAwesomeIcons.users,null,'5/10'),
                          ],
                        ),
                        UiHelper.buildIconInfo(FontAwesomeIcons.calendarAlt, null, '11.23.2021 08:00 - 11.25.2021 16:00'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.buildIconInfo(FontAwesomeIcons.mapMarked, null, 'Pokhara' + ', Nepal'),
                          ],
                        ),
                        UiHelper.buildDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(buttonText: 'Edit', onPressedFunc: ()=>editButtonFunc(), buttonType: ButtonType.TEXT),
                            CustomButton(buttonText: 'Invite', onPressedFunc: ()=>inviteButtonFunc(), buttonType: ButtonType.TEXT),
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
