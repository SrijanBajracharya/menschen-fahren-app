
import 'package:project_menschen_fahren/widgets/components/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  // void _openDrawer()=>_drawerKey.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff8BBA50),
        title: Text(getTitle(context),

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff8BBA50),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
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
      drawer:showHamburgerMenu? const AppDrawer(): null,
      body: buildContent(context),);

  }

  Widget buildContent(BuildContext context);

  String getTitle(BuildContext context);
}