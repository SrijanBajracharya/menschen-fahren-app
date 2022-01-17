import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:provider/provider.dart';

/// Helper class containing different Ui components.
class UiHelper {
  /// Builds a default Divider without Indent
  static Widget buildDivider() {
    return Divider(
      thickness: 1.4,
      color: Color(0xff8BBA50),
    );
  }

  /// Builds a divider with indent.
  static Widget buildDividerWithIndent(
      {required double startIndent, required double endIndent}) {
    return Divider(
      color: Color(0xff8BBA50),
      thickness: 1.4,
      indent: startIndent,
      endIndent: endIndent,
    );
  }

  /// Builds icon info which contains a icon and a text.
  static Widget buildIconInfo(IconData iconData, String? label, String text) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: Icon(
              iconData,
              size: 25.0,
              color: Color(0xFF404040),
            ),
          ),
          (label != null)
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 16, ),
                  ),
                )
              : Text(' '),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ))
        ],
      ),
    );
  }

  /// Builds a description block where a long user text is displayed.
  static Widget buildDescriptionBlock({required String descText}) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Text(
        descText,
        style: TextStyle(fontSize: 18,),
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// Builds a customizable circular avatar with camera icon attached to it.
  static Widget getCircleAvatarWithCamera(
      {required String assetName,
      required double outerRadius,
      required double innerRadius,
      required double cameraRadius,
      required double iconSize,
      required Function onIconClick}) {
    return _buildCircleAvatarWithCamera(
        assetName: assetName,
        outerRadius: outerRadius,
        innerRadius: innerRadius,
        cameraRadius: cameraRadius,
        iconSize: iconSize,
        onIconClick: onIconClick);
  }

  /// Builds a circular avatar with Camera with default values.
  static Widget getCircleAvatarWithCameraDefault(
      {required String assetName, required Function onIconClick}) {
    return _buildCircleAvatarWithCamera(
        assetName: assetName,
        outerRadius: 100.0,
        innerRadius: 96.0,
        cameraRadius: 25.0,
        iconSize: 25.0,
        onIconClick: onIconClick);
  }

  /// Builds a customizable circular avatar.
  static Widget buildCustomCircleAvatar(
      {required String assetName,
      required double outerRadius,
      required double innerRadius}) {
    return _getCircleAvatar(
        assetName: assetName,
        outerRadius: outerRadius,
        innerRadius: innerRadius);
  }

  /// Builds a circular avatar with camera
  static Widget _buildCircleAvatarWithCamera(
      {required String assetName,
      required double outerRadius,
      required double innerRadius,
      required double cameraRadius,
      required double iconSize,
      required Function onIconClick}) {
    return SizedBox(
      child: CircleAvatar(
        radius: outerRadius,
        backgroundColor: Color(0xff8BBA50),
        child: CircleAvatar(
          child: _buildCameraInPicture(
              cameraRadius: cameraRadius,
              iconSize: iconSize,
              onIconClick: onIconClick),
          radius: innerRadius,
          backgroundImage: AssetImage(assetName),
        ),
      ),
    );
  }

  /// Builds a circular avatar with no camera icon attached to it.
  static Widget _getCircleAvatar(
      {required String assetName,
      required double outerRadius,
      required double innerRadius}) {
    return SizedBox(
      child: CircleAvatar(
        radius: outerRadius,
        backgroundColor: Color(0xff8BBA50),
        child: CircleAvatar(
          radius: innerRadius,
          backgroundImage: AssetImage(assetName),
        ),
      ),
    );
  }

  /// Attaches a camera to the circular avatar.
  static Widget _buildCameraInPicture(
      {required double cameraRadius,
      required double iconSize,
      required Function onIconClick}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: CircleAvatar(
        backgroundColor: Color(0xff8BBA50),
        radius: cameraRadius,
        child: IconButton(
          icon: Icon(
            Icons.camera_alt,
            size: iconSize,
            color: Color(0xFF404040),
          ),
          color: Colors.black,
          onPressed: () => onIconClick.call(),
        ),
      ),
    );
  }

  /// Builds a Title Text and places it center of the page.
  static Widget buildCenterTitle({required String title}) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  /// Builds left aligned Title.
  static Widget buildTitle({required String title}) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );
  }

  /// Builds a default button with predefined color.
  static Widget buildButtonDefault(
      {required String buttonText, required Function onPressedFunc}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextButton(
          onPressed: () {
            onPressedFunc;
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xff8BBA50),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
          ),
        ),
      ),
    );
  }

  /// Builds a Dropdown component.
  static Widget getDropdown(
      {required String fieldLabelText,
      required String dropDownLabel,
      required List<String> dropdownItems}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: fieldLabelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.all(5),
        ),
        child: _buildDropdown(
            dropDownLabel: dropDownLabel, dropdownItems: dropdownItems),
      ),
    );
  }

  /// Populates a dropdown values.
  static Widget _buildDropdown(
      {required String dropDownLabel, required List<String> dropdownItems}) {
    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      child: DropdownButton<String>(
        hint: Text(dropDownLabel),
        isExpanded: true,
        elevation: 16,
        underline: DropdownButtonHideUnderline(
          child: Container(),
        ),
        onChanged: (String? newValue) {
          //_authData['eventType'] = newValue!;
        },
        items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    value,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //UiHelper.buildDivider()
                ]),
              ));
        }).toList(),
      ),
    );
  }

  /// Builds a Text input field and validates if the needed.
  static Widget getTextField(
      {required String labelText,
      required String hintText,
      required String validatorMessage,
      required Map<String, String> dataForm,
      required String formKey,
      required bool validate,
      String? initValue}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              // controller: passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                  hintText: hintText),
              initialValue: initValue != null ? initValue : null,
              validator: (value) {
                if (validate) {
                  if (value == null || value.isEmpty) {
                    return validatorMessage;
                  }
                  return null;
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                dataForm[formKey] = value!;
              },
            ),
          ],
        ));
  }

  static Widget getPasswordField(
      String labelText,
      String hintText,
      String validatorMessage,
      String formKey,
      Function toggleConsumer,
      bool validate) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              // controller: passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                  hintText: hintText),
              validator: (value) {
                if (validate) {
                  if (value == null || value.isEmpty) {
                    return validatorMessage;
                  }
                  return null;
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                //_authData[formKey] = value!;
              },
            ),
          ],
        ));
  }

  static Widget getTextFieldWithRegExValidation(
      {required String labelText,
      required String hintText,
      required String validatorMessage,
      required Map<String, String> dataForm,
      required String formKey,
      required String regEx,
      required String regExValidationErrorMessage,
      required bool validate,
      String? initValue}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: initValue,
              // controller: passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                  hintText: hintText),
              validator: (value) {
                if (validate) {
                  if (value == null || value.isEmpty) {
                    return validatorMessage;
                  }
                  if (!RegExp(regEx).hasMatch(value)) {
                    return regExValidationErrorMessage;
                  }
                  return null;
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                dataForm[formKey] = value!;
              },
            ),
          ],
        ));
  }

  /// Builds a Description input field.
  static Widget getDescriptionFieldWithValidation(
      {required String label,
      required String validationText,
      required Map<String, String> dataForm,
      required String formKey,
      String? initValue}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        initialValue: initValue,
        decoration: InputDecoration(
            labelText: label,
            hintText: "Enter your text here",
            border: const OutlineInputBorder()),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationText;
          }
          return null;
        },
        onSaved: (value) {
          dataForm[formKey] = value!;
        },
        minLines: 1,
        maxLines: 4,
      ),
    );
  }

  static void showErrorDialog(
      {required BuildContext context,
      required String header,
      required String message,
      String? buttonText}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(header),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: (buttonText == null) ? const Text('Okay') : Text(buttonText),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      backgroundColor: Color(0xff8BBA50),
      content: Text(message),
      /*action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),*/
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessDialog(
      {required BuildContext context,
      required String header,
      required String message,
      String? buttonText,
      Function? buttonFunc}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(header),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: (buttonText == null) ? const Text('Okay') : Text(buttonText),
            onPressed: () {
              if (buttonFunc != null) {
                buttonFunc.call();
              } else {
                Navigator.of(ctx).pop();
              }
            },
          )
        ],
      ),
    );
  }

  static void showYesNoDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required String yesButtonText,
      required String noButtonText,
      required Function yesButtonOperation,
      required Function noButtonOperation}) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => yesButtonOperation.call(),
            child: Text(yesButtonText),
          ),
          TextButton(
            onPressed: () => noButtonOperation.call(),
            child: Text(noButtonText),
          ),
        ],
      ),
    );
  }

  static void showYesNoDialogWithContent(
      {required BuildContext context,
      required String title,
      required Widget content,
      required String yesButtonText,
      required String noButtonText,
      required Function yesButtonOperation,
      required Function noButtonOperation}) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: content,
        actions: <Widget>[
          TextButton(
            onPressed: () => yesButtonOperation.call(),
            child: Text(yesButtonText),
          ),
          TextButton(
            onPressed: () => noButtonOperation.call(),
            child: Text(noButtonText),
          ),
        ],
      ),
    );
  }
  
}
