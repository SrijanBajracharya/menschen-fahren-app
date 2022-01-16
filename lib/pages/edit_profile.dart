import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/user_profile_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/custom_dropdown.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class EditProfile extends StatefulWidget {

  final UserProfileResponse? userProfile;

  EditProfile({Key?key, this.userProfile});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends StatefulBasePage<EditProfile> {
  _EditProfileState() : super(true);
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _editProfileData = {
    'aboutMe': '',
    'hobbies': '',
    'descText': ''
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
          UiHelper.getTextField(
              labelText: "Age",
              hintText: "Please Enter your age",
              validatorMessage: "Please Enter your age",
              dataForm: _editProfileData,
              formKey: "age",
              validate: true,
              initValue: widget.userProfile?.dateOfBirth
          ),
          CustomDropdown(
            label: 'Gender',
            dropdownLabel: 'Choose',
            dropdownItems: _getGenderList(),
            validate: true,
            dataForm: _editProfileData,
            formKey: "gender",
            initValue: widget.userProfile?.gender
          ),
          UiHelper.getTextField(
              labelText: "Working at",
              hintText: "Please Enter your Work",
              validatorMessage: 'Please enter your Work',
              dataForm: _editProfileData,
              formKey: 'work',
              validate: false,
              initValue: widget.userProfile?.address
          ),
          UiHelper.getTextField(
              labelText: "Your are From",
              hintText: "Please Enter your Address",
              validatorMessage: 'Please enter the Address',
              dataForm: _editProfileData,
              formKey: 'address',
              validate: true,
              initValue: widget.userProfile?.address
          ),
          UiHelper.getTextField(
              labelText: "Currently Living in",
              hintText: "Please Enter your Current Address",
              validatorMessage: 'Please enter Address',
              dataForm: _editProfileData,
              formKey: 'currentAddress',
              validate: true,
              initValue: widget.userProfile?.address
          ),
          UiHelper.getTextField(
              labelText: "Mobile Number",
              hintText: "Please Enter your Mobile number",
              validatorMessage: 'Please enter your Mobile Number',
              dataForm: _editProfileData,
              formKey: 'mobileNo',
              validate: true,
              initValue: widget.userProfile?.phoneNumber
          ),
          UiHelper.getTextFieldWithRegExValidation(
              labelText: "Email Id",
              hintText: "Please Enter your Email Id",
              validatorMessage: 'Please enter your Email Id',
              dataForm: _editProfileData,
              formKey: 'emailAddress',
              regEx: "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
              regExValidationErrorMessage: 'Invalid Email',
              validate: true,
              initValue: widget.userProfile?.user.email
          ),
          UiHelper.getDescriptionFieldWithValidation(
              label: "About me",
              validationText: "Please Enter something about You.",
              formKey: 'aboutMe',
              dataForm: _editProfileData,
              initValue: widget.userProfile?.description
          ),
          UiHelper.getDescriptionFieldWithValidation(
              label: "About my Hobbies",
              validationText: "Please enter your hobbie",
              formKey: 'hobbies',
              dataForm: _editProfileData,
              initValue: widget.userProfile?.hobbies
          ),
          CustomButton(
              buttonText: (widget.userProfile!=null)?'Update':'Save',
              onPressedFunc: () => _onUpdateCall(),
              buttonType: ButtonType.OUTLINE)
        ],
      ),
    ));
  }

  List<String> _getGenderList() {
    List<String> eventTypes = <String>['M', 'F', 'O'];
    return eventTypes;
  }

  Future<void> _onUpdateCall() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    if(widget.userProfile!=null){

    }else{

    }
  }

  @override
  String getTitle(BuildContext context) {
    return "Edit Profile";
  }
}
