import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_type.dart';

class CustomButton extends StatelessWidget {

  String buttonText;

  Function onPressedFunc;

  ButtonType buttonType;

  CustomButton({Key? key, required this.buttonText, required this.onPressedFunc, required this.buttonType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: getButton(this.buttonType,this.onPressedFunc),
      ),
    );
  }

  Widget getButton(ButtonType buttonType, Function onPressedFunc){
    switch(buttonType){
      case ButtonType.TEXT:
        return getTextButtonField(onPressedFunc);
      case ButtonType.OUTLINE:
        return getOutlineButtonField(onPressedFunc);
    }
  }

  Widget getOutlineButtonField(Function onPressedFunc){
    return OutlinedButton(
        onPressed: () {
          print('im pressed');
          onPressedFunc.call();
        },
        child:getBody()
    );
  }

  Widget getTextButtonField(Function onPressedFunc){
    return TextButton(
      onPressed: () {
        print('im pressed');
        onPressedFunc.call();
      },
      child:getTextButtonBody()
    );
  }

  Widget getBody(){
    return Container(
      padding:
      EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      decoration: BoxDecoration(
        color: Color(0xff8BBA50),
        borderRadius:
        BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: 'SF Pro',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget getTextButtonBody(){
    return Container(
      padding:
      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: 'SF Pro',
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

