import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_color.dart';
import 'package:project_menschen_fahren/models/button_type.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;

  final Function onPressedFunc;

  final ButtonType buttonType;

  ///Use this only for ButtonType Elevated.
  final ButtonColor? buttonColor;

  CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onPressedFunc,
      required this.buttonType,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: getButton(this.buttonType, this.onPressedFunc, this.buttonColor),
      ),
    );
  }

  Widget getButton(ButtonType buttonType, Function onPressedFunc, ButtonColor? buttonColor) {
    int ? color;
    if(buttonColor!=null){
      color= getColorFromButtonColor(buttonColor);
    }

    switch (buttonType) {
      case ButtonType.TEXT:
        return getTextButtonField(onPressedFunc,color);
      case ButtonType.OUTLINE:
        return getOutlineButtonField(onPressedFunc,color);
      case ButtonType.ELEVATED:
        return getElevatedButton(onPressedFunc,color);
    }
  }

  Widget getOutlineButtonField(Function onPressedFunc,int? color) {
    return OutlinedButton(
        onPressed: () {
          onPressedFunc.call();
        },
        child: getBody());
  }

  Widget getElevatedButton(Function onPressedFunc,int? color) {
    return ElevatedButton(
        onPressed: () {
          onPressedFunc.call();
        },
        style: ElevatedButton.styleFrom(
          primary: color!=null ? Color(color): Color(0xff8BBA50),
        ),
        child: getElevatedButtonBody());
  }

  Widget getTextButtonField(Function onPressedFunc, int? color) {
    return TextButton(
        onPressed: () {
          onPressedFunc.call();
        },
        child: getTextButtonBody());
  }

  Widget getElevatedButtonBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget getBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget getTextButtonBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }

  int getColorFromButtonColor(ButtonColor buttonColor){
    final int btnColor;
    switch(buttonColor){
      case ButtonColor.ERROR:
        btnColor= 0xffBC2B2B;
        break;
      case ButtonColor.SECONDARY:
        btnColor= 0xff0096c7;
        break;
      case ButtonColor.WARNING:
        btnColor= 0xffffcc00;
        break;
      case ButtonColor.PRIMARY:
      default:
        btnColor= 0xff8BBA50;
        break;
    }
    return btnColor;
  }
}
