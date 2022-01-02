import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Builds Password field with built-in show password icon.<br/>
/// labelText: (required) The password field label.<br/>
/// hintText: (required) The password hint Text label.<br/>
/// validationMessage: (required) The message to show if validation fails.<br/>
class CustomPasswordField extends StatefulWidget {

  /// The Password field label.
  final String labelText;

  /// The password field hint Text.
  final String hintText;

  /// The password field validation Message.
  final String validationMessage;

  CustomPasswordField({Key? key, required this.labelText, required this.hintText, required this.validationMessage}) : super(key: key);

  @override
  _CustomPasswordState createState() => _CustomPasswordState();

}

class _CustomPasswordState extends State<CustomPasswordField>{

  /// Obscure text for password.
  bool _obscureText = true;

  /// Toggles the visibility of password.
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /// change visibility icon.
  Icon _changeIcon(){
    if(_obscureText){
      return Icon(Icons.visibility);
    }
    return Icon(Icons.visibility_off);
  }


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
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  suffixIcon: InkWell(
                    onTap: _toggle, // add padding to adjust icon
                    child: _changeIcon(),
                  ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.validationMessage;
                }
                return null;
              },
              onSaved: (value) {
               // _authData['password'] = value!;
              },
              obscureText: _obscureText,
            ),
          ]
      )
    );
  }

}