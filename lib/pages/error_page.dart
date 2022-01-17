import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_color.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';

// TODO: Custom Error Message for normal User
// TODO: Expandable Details Section for Analysis
class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Error"),
        ),
        body: Center(
          child: CustomButton(
            buttonText: 'Something went wrong',
            onPressedFunc: () => _navigate(context),
            buttonType: ButtonType.ELEVATED,
            buttonColor: ButtonColor.ERROR,
          ),
        ));
  }

  void _navigate(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutesName.MAIN_PAGE);
  }
}
