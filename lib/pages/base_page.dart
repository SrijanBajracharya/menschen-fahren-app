import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/notification_data.dart';
import 'package:project_menschen_fahren/models/user_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/widgets/components/app_drawer.dart';
import 'package:project_menschen_fahren/widgets/components/notification.dart';

abstract class BasePage extends StatelessWidget {

  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(getTitle(context)),
      ),
      body: buildContent(context),);
  }

  Widget buildContent(BuildContext context);

  String getTitle(BuildContext context);
}

abstract class StatefulBasePage<T extends StatefulWidget> extends State<T> {

  bool showHamburgerMenu;
  StatefulBasePage(this.showHamburgerMenu) : super();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _openDrawer()=>_drawerKey.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: AppDrawer(),
      //endDrawer:showHamburgerMenu? const AppDrawer(): null,
      appBar: AppBar(
        backgroundColor: Color(0xff8BBA50),
        toolbarTextStyle: TextStyle(
          fontFamily: Constants.PRIMARY_FONT_FAMILY
        ),
        titleTextStyle: TextStyle(
          fontFamily: Constants.PRIMARY_FONT_FAMILY
        ),
        title: Text(
          getTitle(context),
          style: TextStyle(
            fontFamily: Constants.PRIMARY_FONT_FAMILY
          ),
        ),
        /*actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () => openDialog()),
          //IconButton(icon: Icon(Icons.account_circle_sharp), onPressed: ()=>_openDrawer(),),
        ],*/
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff8BBA50),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: Constants.PRIMARY_FONT_FAMILY
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'My Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),

      body: buildContent(context),);

  }

  Widget buildContent(BuildContext context);

  String getTitle(BuildContext context);

  void openDialog() {

    List<UserNotification> userNotifications = <UserNotification>[];
    userNotifications.add(UserNotification(user: 'Srijan', eventName: 'Pokhara Trip', requestToJoin: true));
    userNotifications.add(UserNotification(user: 'John', eventName: 'Japan Trip', requestToJoin: false));

    NotificationData notificationData = NotificationData(notifications: userNotifications);

    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return NotificationDialog(notificationData: NotificationData(notifications: userNotifications));
        },
        fullscreenDialog: true));
  }

}
