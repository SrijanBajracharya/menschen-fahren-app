import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/custom_combobox.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() {
    return _SettingsState();
  }
}

class _SettingsState extends StatefulBasePage<Settings> {
  _SettingsState() : super(showHamburgerMenu: true,showNotification: false,showBottomNavigation: true,currentIndex: 4);

  bool showPhoneNumber = false;
  bool showEmailId=false;

  final Map<String, dynamic> _settingData = {
    'showPhoneNumber': false,
    'showEmailId': false,
    'deactivate': false,
  };

  void saveSettings(){
    print(_settingData);
  }

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomCheckBox(labelText: 'Show Phone Number', dataForm: _settingData,formKey: 'showPhoneNumber',),
                        CustomCheckBox(labelText: 'Show Email Id', dataForm: _settingData,formKey: 'showEmailId',),
                        CustomCheckBox(labelText: 'Deactivate Profile', dataForm: _settingData,formKey: 'deactivate',),
                        CustomButton(buttonText: 'Save', onPressedFunc: ()=>saveSettings(), buttonType: ButtonType.OUTLINE)
                      ],
                    ),
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  //Positioned
                ], //<Widget>[]
              ), //Stack
            )
        )
    );
  }

  @override
  String getTitle(BuildContext context) {
    return 'Settings';
  }

}