import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/custom_dropdown.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends StatefulBasePage<EditProfile> {
  _EditProfileState() : super(true);
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _editProfileData = {
    'aboutMe': '',
    'hobbies': '',
    'descText':''
  };

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),

              UiHelper.getTextField("Age","Please Enter your age","Please Enter your age","age",true),
              CustomDropdown(label: 'Gender', dropdownLabel: 'Choose', dropdownItems: _getGenderList(),validate: true,),
              UiHelper.getTextField("Working at", "Please Enter your Work", 'Please enter your Work', 'work',false),

              UiHelper.getTextField("Your are From", "Please Enter your Address", 'Please enter the Address', 'address',true),

              UiHelper.getTextField("Currently Living in", "Please Enter your Current Address", 'Please enter Address', 'currentAddress',true),
              UiHelper.getTextField("Mobile Number", "Please Enter your Mobile number", 'Please enter your Mobile Number', 'mobileNo',true),
              UiHelper.getTextFieldWithRegExValidation("Email Id", "Please Enter your Email Id", 'Please enter your Email Id',_editProfileData, 'emailAddress',"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]", 'Invalid Email',true),

              UiHelper.getDescriptionFieldWithValidation(label: "About me",validationText: "Please Enter something about You.",formKey: _editProfileData['aboutMe']!),
              UiHelper.getDescriptionFieldWithValidation(label: "About my Hobbies", validationText: "Please enter your hobbie",formKey: _editProfileData['hobbies']!),
              CustomButton(buttonText: 'Update', onPressedFunc: ()=>_onUpdateCall(), buttonType: ButtonType.TEXT)
            ],
          ),
        )
    );

  }

  List<String> _getGenderList(){
    List<String> eventTypes = <String>['M','F','O'];
    return eventTypes;
  }

  Future<void> _onUpdateCall() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
  }


  @override
  String getTitle(BuildContext context) {
    return "Edit Profile";
  }
}