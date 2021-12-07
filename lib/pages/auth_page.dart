import 'package:project_menschen_fahren/models/exceptions/http_exception.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

/// The login screen.
class AuthScreen extends StatelessWidget {
  //const AuthScreen({Key? key}) : super(key: key);
  const AuthScreen({Key? key, String? routeName, String? message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const LoginPage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

  /// Obscure text for password.
  bool _obscureText = true;

  _LoginPageState() : super(false);

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  String getTitle(BuildContext context) {
    return LoginPage.TITLE;
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
  Future<void> _pressedLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    try {
      final canLogin =
          await Provider.of<AuthenticationTokenProvider>(context, listen: false)
              .login('', _authData['email']!,
                  _authData['password']!);
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
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: TextFormField(
              // controller: usernameController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter you Email ID'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email ID';
                }
                if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                  return 'Invalid Email';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value!;
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    // controller: passwordController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Password",
                        hintText: "Please Enter your Password"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                    obscureText: _obscureText,
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Show Password"),
                    value: !_obscureText,
                    onChanged: (bool? newValue) => _toggle(),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  OutlinedButton(
                    onPressed: () => _pressedLogin(context),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff8BBA50),
                        minimumSize: const Size(100, 50),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 80
                        )
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
