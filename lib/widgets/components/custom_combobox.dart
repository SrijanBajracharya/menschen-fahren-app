import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Builds Password field with built-in show password icon.<br/>
/// labelText: (required) The password field label.<br/>
/// hintText: (required) The password hint Text label.<br/>
/// validationMessage: (required) The message to show if validation fails.<br/>
class CustomCheckBox extends StatefulWidget {

  /// The Password field label.
  final String labelText;

  Map<String,dynamic> dataForm;

  String formKey;

  CustomCheckBox({Key? key, required this.labelText, required this.dataForm, required this.formKey}) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();

}

class _CustomCheckBoxState extends State<CustomCheckBox>{



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: CheckboxListTile(
          title: Text(widget.labelText, style: TextStyle(fontSize: 18),), //    <-- label
          value: widget.dataForm[widget.formKey],
          onChanged: (newValue) {
            setState(() {
              widget.dataForm[widget.formKey] = newValue;
            });
          },
        )
    );
  }

}