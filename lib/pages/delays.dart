import 'package:project_menschen_fahren/widgets/components/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Delays extends StatelessWidget {

  bool showHamburgerMenu;

  ///Constructor for displaying a hamburger menu or not.
  Delays(this.showHamburgerMenu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Delays & Cancellations"),
        ),
        drawer:showHamburgerMenu? const AppDrawer(): null,
        body: const Center(child: Text("no Content")));
  }
}
