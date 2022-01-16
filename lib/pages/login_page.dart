import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/exceptions/http_exception.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:project_menschen_fahren/widgets/components/password_field.dart';
import 'package:provider/provider.dart';

/// Stateful widget that represents the login page.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String TITLE = 'Login Page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

/// State of the LoginPage.
class _LoginPageState extends StatefulBasePage<LoginPage> {
  /// Key of the form.
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Map containing the details from the login form.
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  _LoginPageState() : super(showHamburgerMenu: false,showBottomNavigation: false,showNotification: false);

  @override
  String getTitle(BuildContext context) {
    return LoginPage.TITLE;
  }

  void _register(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RoutesName.ROUTE_REGISTRATION);
  }

  /// Handling the press on the login button.
  Future<void> _pressedLogin(BuildContext context) async {
    print('here i am');

    print(_authData['email']);
    print(_authData['password']);
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    try {
      final canLogin =
          await Provider.of<AuthenticationTokenProvider>(context, listen: false)
              .login(_authData['email']!, _authData['password']!);
      if (canLogin) {
        Navigator.of(context).pushReplacementNamed(RoutesName.MAIN_PAGE);
      }
    } on HttpException catch (error) {
      //TODO: this needs to be verified.
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('invalid_grant')) {
        errorMessage =
            'The User is invalid. Either Username of password is incorrect.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      UiHelper.showErrorDialog(
          context: context, header: 'Error', message: errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      UiHelper.showErrorDialog(
          context: context, header: 'Error', message: errorMessage);
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                UiHelper.getTextFieldWithRegExValidation(
                    labelText: 'Email Id',
                    hintText: 'Enter Email Id',
                    validatorMessage: 'Please Enter Email Id',
                    dataForm: _authData,
                    formKey: 'email',
                    regEx: "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                    regExValidationErrorMessage: 'Invalid Email',
                    validate: true),
                CustomPasswordField(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    formKey: 'password',
                    dataForm: _authData,
                    validationMessage: 'Enter your Password.'),
                CustomButton(
                    buttonText: 'Login',
                    onPressedFunc: () => _pressedLogin(context),
                    buttonType: ButtonType.OUTLINE),
                CustomButton(
                    buttonText: 'Register',
                    onPressedFunc: () => _register(context),
                    buttonType: ButtonType.TEXT)
              ],
            ),
          ))
        ]));
  }
}
