import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/exceptions/http_exception.dart';
import 'package:project_menschen_fahren/models/user_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/user_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:project_menschen_fahren/widgets/components/password_field.dart';
import 'package:provider/provider.dart';


/// Stateful widget that represents the login page.
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  static const String TITLE = 'Registration';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

/// State of the LoginPage.
class _RegistrationPageState extends StatefulBasePage<RegistrationPage> {
  /// Key of the form.
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Map containing the details from the login form.
  final Map<String, String> _authData = {
    'firstName': '',
    'lastName':'',
    'username':'',
    'email': '',
    'password': '',
  };


  _RegistrationPageState() : super(false);


  @override
  String getTitle(BuildContext context) {
    return RegistrationPage.TITLE;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  /// Handling the press on the login button.
  Future<void> _pressedRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    UserService service = UserService();

    if(_authData['password'] != _authData['confirmPassword']){
      UiHelper.showErrorDialog(context: context, header: 'Error!!', message: 'Password does not match.');
      return;
    }

    try{
      UserResponse user = await service.createUser(_authData);
      print(user);
      Navigator.of(context).pushReplacementNamed(RoutesName.ROUTE_LOGIN);
    }catch(error){
      UiHelper.showErrorDialog(context: context, header: 'Error!!', message: error.toString());
    }




  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child:Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),
                      UiHelper.getTextField("First Name", "Enter First Name", 'Please Enter First Name',_authData, 'firstName',true),
                      UiHelper.getTextField("Last Name", "Enter Last Name", 'Please Enter Last Name', _authData,'lastName',true),
                      UiHelper.getTextField("User Name", "Enter User name", 'Please Enter Username', _authData,'username',true),
                      UiHelper.getTextFieldWithRegExValidation('Email Id', 'Enter Email Id', 'Please Enter Email Id',_authData, 'email', "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]", 'Invalid Email', true),
                      CustomPasswordField(labelText: 'Password', hintText: 'Enter your Password', formKey: 'password',dataForm: _authData,validationMessage: 'Enter your Password.'),
                      CustomPasswordField(labelText: 'Rewrite Password', hintText: 'Rewrite your Password', formKey: 'confirmPassword',dataForm: _authData,validationMessage: 'Rewrite your Password.'),
                      CustomButton(buttonText: 'Signup', onPressedFunc: ()=>_pressedRegister(context), buttonType: ButtonType.OUTLINE)
                    ],
                  ),
                ),
              )
            ]
        )
    );
  }
}


