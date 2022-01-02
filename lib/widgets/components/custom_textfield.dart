import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String label;

  final String hintText;

  final bool? validate;

  final String? validatorMessage;

  final String? regEx;

  String? selectedValue;

  CustomTextField({Key? key, required this.label, required this.hintText, this.validate, this.validatorMessage, this.regEx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              // controller: passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: label,
                  hintText: hintText
              ),
              validator: (value) {
                if(validate==true){
                  if (value == null || value.isEmpty) {
                    return (validatorMessage!=null)?validatorMessage:'Validation Error';
                  }

                  if(!RegExp(regEx!).hasMatch(value)){
                    return "Regular Expression doesn't match";
                  }
                  return null;
                }else{
                  return null;
                }
              },
              onChanged:(String? newValue){
                selectedValue=newValue!;
              } ,
              onSaved: (value) {
                //_authData[formKey] = value!;
              },
            ),
          ],
        )
    );
  }


}

