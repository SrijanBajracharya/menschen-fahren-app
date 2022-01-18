import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/notification_data.dart';
import 'package:project_menschen_fahren/models/user_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/pages/create_event_page.dart';
import 'package:project_menschen_fahren/pages/home.dart';
import 'package:project_menschen_fahren/pages/profile.dart';
import 'package:project_menschen_fahren/route_generator.dart';
import 'package:project_menschen_fahren/routes_name.dart';
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
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context);

  String getTitle(BuildContext context);
}

abstract class StatefulBasePage<T extends StatefulWidget> extends State<T> {
  bool showHamburgerMenu;
  int? currentIndex;
  bool? showBottomNavigation = true;
  bool? showNotification = true;

  //Add back button only in the page where needed.
  //NOTE: This is not a right solution, back button should be displayed if we navigate using pushNamed but currently because
  //of lack of proper knowledge, using pushedNamedReplacement instead everywhere.
  // Is showBackButton is true: It is compulsory to give the routeBackTo.
  bool? showBackButton = false;
  //Compulsory field if showBackButton is true.
  String? routeBackTo;

  StatefulBasePage(
      {required this.showHamburgerMenu,
      this.showBottomNavigation,
      this.showNotification,
      this.currentIndex,
      this.showBackButton,
      this.routeBackTo})
      : super();

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _openDrawer() => _drawerKey.currentState!.openDrawer();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: showHamburgerMenu ? AppDrawer() : null,
      appBar: AppBar(
        leading: (showBackButton == true)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () =>{
                  if(routeBackTo !=null){
                    Navigator.pushReplacementNamed(context, routeBackTo!)
                  }

                },
              )
            : null,
        backgroundColor: Color(0xffffffff),
        toolbarTextStyle: TextStyle(fontFamily: Constants.PRIMARY_FONT_FAMILY),
        titleTextStyle: TextStyle(fontFamily: Constants.PRIMARY_FONT_FAMILY),
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
        title: Text(
          getTitle(context),
          style: TextStyle(color: Colors.black87, fontSize: 20),
        ),
        actions: (showNotification == null || showNotification == true)
            ? <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.black87,
                    ),
                    onPressed: () => openDialog()),
                //IconButton(icon: Icon(Icons.account_circle_sharp), onPressed: ()=>_openDrawer(),),
              ]
            : null,
      ),
      bottomNavigationBar:
          (showBottomNavigation == null || showBottomNavigation == true)
              ? _showBottomNav()
              : null,
      body: buildContent(context),
    );
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      //backgroundColor: Color(0xff8BBA50),
      selectedItemColor: Color(0xff8BBA50),
      type: BottomNavigationBarType.shifting,
      onTap: _onTap,
      currentIndex:
          (this.currentIndex != null) ? this.currentIndex! : _selectedIndex,
      unselectedItemColor: Colors.black87,
      elevation: 15,
      backgroundColor: Color(0xffEFEFEF),
      selectedFontSize: 16,
      unselectedFontSize: 14,
      selectedIconTheme: IconThemeData(size: 30),
      unselectedIconTheme: IconThemeData(size: 26),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
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
    );
  }

  // _onTap function
  void _onTap(int index) {
    ///NOTE: this logic needs to change because right now, the navigator is used, and the page pass the selected index. which is not the correct way. Need to recheck the named navigation logic
    if (currentIndex != null && currentIndex != index) {
      // Manage your route names here
      switch (index) {
        case 1:
          Navigator.pushReplacementNamed(context, RoutesName.FAVORITES);
          break;
        case 2:
          Navigator.pushReplacementNamed(context, RoutesName.MY_EVENT);
          break;
        case 3:
          Navigator.pushReplacementNamed(context, RoutesName.CREATE_EVENT);
          break;
        case 4:
          Navigator.pushReplacementNamed(context, RoutesName.PROFILE);
          break;
        case 0:
        default:
          Navigator.pushReplacementNamed(context, RoutesName.MAIN_PAGE);
          break;
      }
    }
  }

  Widget buildContent(BuildContext context);

  String getTitle(BuildContext context);

  void openDialog() {
    List<UserNotification> userNotifications = <UserNotification>[];
    userNotifications.add(UserNotification(
        user: 'Srijan', eventName: 'Pokhara Trip', requestToJoin: true));
    userNotifications.add(UserNotification(
        user: 'John', eventName: 'Japan Trip', requestToJoin: false));

    NotificationData notificationData =
        NotificationData(notifications: userNotifications);

    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return NotificationDialog(
              notificationData:
                  NotificationData(notifications: userNotifications));
        },
        fullscreenDialog: true));
  }
}
