import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';

class CustomAlertDialog extends StatelessWidget{

  final Function yesButtonFunc;

  final Function noButtonFunc;

  final String yesButtonText;

  final String noButtonText;

  final String titleText;

  final String message;

  CustomAlertDialog({Key ? key,required this.titleText, required this.message, required this.yesButtonText, required this.noButtonText, required this.yesButtonFunc, required this.noButtonFunc}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.titleText),
      content: SingleChildScrollView(
        child: ListBody(
          children:  <Widget>[
            Text(this.message),
          ],
        ),
      ),
      actions: <Widget>[

        CustomButton(buttonText: yesButtonText, onPressedFunc: yesButtonFunc.call(), buttonType: ButtonType.OUTLINE),
        CustomButton(buttonText: noButtonText, onPressedFunc: noButtonFunc.call(), buttonType: ButtonType.TEXT)

      ],
    );
  }

}