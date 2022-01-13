import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_type.dart';

class CustomDropdown extends StatefulWidget {
  final String label;

  final String dropdownLabel;

  final List<String> dropdownItems;

  bool? validate;

  Map<String, String> dataForm;

  String formKey;

  CustomDropdown(
      {Key? key,
      required this.label,
      required this.dropdownLabel,
      required this.dropdownItems,
      required this.dataForm,
      required this.formKey,
      this.validate})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.all(5),
        ),
        child: _buildDropdown(),
      ),
    );
  }

  /// Populates a dropdown values.
  Widget _buildDropdown() {
    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      child: DropdownButtonFormField(
        value: selectedValue,
        hint: Text(widget.dropdownLabel),
        isExpanded: true,
        elevation: 16,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        onChanged: (String? newValue) {
          //setState(() {
            selectedValue = newValue!;
          //});
        },
        onSaved: (String? value) {
          widget.dataForm[widget.formKey] = value!;
        },
        validator: (value) => (widget.validate == true)
            ? (value == null ? 'Field required' : null)
            : null,
        items:
            widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
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
}
