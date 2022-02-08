import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/notification_data.dart';
import 'package:project_menschen_fahren/models/notification_response.dart';
import 'package:project_menschen_fahren/models/user_notification.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationData notificationData;

  NotificationDialog({Key? key, required this.notificationData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: buildNotificationItem(this.notificationData.notifications),
    );
  }

  Widget buildNotificationItem(List<NotificationResponse> userNotification) {
    TextStyle defaultStyle = TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontFamily: Constants.PRIMARY_FONT_FAMILY);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: (ListView.builder(
          itemCount: userNotification.length,
          itemBuilder: (context, index) {
            return InkWell(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: _buildNotificationWidget(userNotification, index)
            ));
          },
        )),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildNotificationWidget(List<NotificationResponse> userNotification, int index){
    print(userNotification[index].notificationStatus);
    print(userNotification[index].notificationType);
    Widget widget;
    if(userNotification[index].notificationType == 'request' &&
        userNotification[index].notificationStatus == 'pending'){
      print('if cond');
      widget = _buildPendingRequestWidget(userNotification, index);
    }else if(userNotification[index].notificationType == 'invite' &&
        userNotification[index].notificationStatus == 'pending'){
      print('first else if cond');
      widget = _buildPendingInviteWidget(userNotification, index);
    }else if(userNotification[index].notificationType == 'request' &&
        (userNotification[index].notificationStatus == 'approved' || userNotification[index].notificationStatus == 'declined')){
      print('second else if');
      widget = _buildRequestApprovedDeclinedWidget(userNotification, index);
    }else{
      print('else cond');
      widget = _buildApprovedDeclinedInviteWidget(userNotification, index);
    }
    return widget;
  }

  Widget _buildRequestApprovedDeclinedWidget(
      List<NotificationResponse> userNotification, int index) {
    return Column(
      children: [
        if (userNotification[index].matchedReceiverUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(text: ' You have ${userNotification[index].notificationStatus} the request from '),
                    TextSpan(
                        text: userNotification[index].senderUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' for '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
        else if (userNotification[index].matchedSenderUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(text: 'Your request is ${userNotification[index].notificationStatus} by '),
                    TextSpan(
                        text: userNotification[index].receiverUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' for '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
      ],
    );
  }

  Widget _buildApprovedDeclinedInviteWidget(
      List<NotificationResponse> userNotification, int index) {
    return Column(
      children: [
        if (userNotification[index].matchedReceiverUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(text: ' You have ${userNotification[index].notificationStatus} the invitation from  '),
                    TextSpan(
                        text: userNotification[index].senderUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' for '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
        else if (userNotification[index].matchedSenderUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(text: 'Your invitation has been ${userNotification[index].notificationStatus} by '),
                    TextSpan(
                        text: userNotification[index].receiverUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' for '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
      ],
    );
  }

  Widget _buildPendingInviteWidget(
      List<NotificationResponse> userNotification, int index) {
    return Column(
      children: [
        if (userNotification[index].matchedReceiverUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(
                        text: userNotification[index].senderUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' has sent you an invitation for '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      buttonText: 'Accept',
                      onPressedFunc: () => acceptButton(),
                      buttonType: ButtonType.OUTLINE),
                  CustomButton(
                      buttonText: 'Deny',
                      onPressedFunc: () => denyButton(),
                      buttonType: ButtonType.OUTLINE),
                ],
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
        else if (userNotification[index].matchedSenderUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(text: 'You have sent an invitation to '),
                    TextSpan(
                        text: userNotification[index].receiverUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' for '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
      ],
    );

  }

  Widget _buildPendingRequestWidget(
      List<NotificationResponse> userNotification, int index) {
    return Column(
      children: [
        if (userNotification[index].matchedReceiverUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(
                        text: userNotification[index].senderUser.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(text: ' wants to join the event '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      buttonText: 'Approve',
                      onPressedFunc: () => approveButton(),
                      buttonType: ButtonType.OUTLINE),
                  CustomButton(
                      buttonText: 'Reject',
                      onPressedFunc: () => rejectButton(),
                      buttonType: ButtonType.OUTLINE),
                ],
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
        else if (userNotification[index].matchedSenderUserId)
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  style: _getTextDefault(),
                  children: <TextSpan>[
                    TextSpan(text: ' You have sent a request to  '),
                    TextSpan(
                        text: userNotification[index].receiverUser.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(text: ' to join  '),
                    TextSpan(
                        text: userNotification[index].event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              UiHelper.buildDividerWithIndent(startIndent: 20, endIndent: 20)
            ],
          )
      ],
    );
  }

  TextStyle _getTextDefault() {
    return TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontFamily: Constants.PRIMARY_FONT_FAMILY);
  }

  void approveButton() {
    print('approve is clicked');
  }

  void rejectButton() {
    print('reject is clicked');
  }

  void acceptButton() {
    print('accept is clicked');
  }

  void denyButton() {
    print('deny is clicked');
  }
}
