import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/notification_data.dart';
import 'package:project_menschen_fahren/models/user_notification.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationData notificationData;

  NotificationDialog({Key? key, required this.notificationData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: const Text('Notification',style: TextStyle(color: Colors.black87),
        ),
      ),
      body: buildNotificationItem(this.notificationData.notifications),
    );
  }

  Widget buildNotificationItem(List<UserNotification> userNotification) {
    TextStyle defaultStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: (ListView.builder(
          itemCount: userNotification.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: userNotification[index].requestToJoin?Column(
                  children: [

                    RichText(
                      text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(text: userNotification[index].user, style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' wants to join the event '),
                          TextSpan(text: userNotification[index].eventName, style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(buttonText: 'Approve', onPressedFunc: ()=>approveButton(), buttonType: ButtonType.OUTLINE),
                        CustomButton(buttonText: 'Reject', onPressedFunc: ()=>rejectButton(), buttonType: ButtonType.OUTLINE),
                      ],
                    ),
                    UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
                  ],

                ):Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(text: userNotification[index].user, style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' sent you an invitation for '),
                          TextSpan(text: userNotification[index].eventName, style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(buttonText: 'Accept', onPressedFunc: ()=>acceptButton(), buttonType: ButtonType.OUTLINE),
                        CustomButton(buttonText: 'Deny', onPressedFunc: ()=>denyButton(), buttonType: ButtonType.OUTLINE),
                      ],
                    ),
                    UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
                  ],

                ),
              ));
          },
        )),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

  void approveButton(){
    print('approve is clicked');
  }

  void rejectButton(){
    print('reject is clicked');
  }

  void acceptButton(){
    print('accept is clicked');
  }

  void denyButton(){
    print('deny is clicked');
  }
}
