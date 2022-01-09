import 'dart:async';
import 'dart:convert';

import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/logger.dart';
import 'package:project_menschen_fahren/models/auth_response.dart';
import 'package:project_menschen_fahren/models/auth_response1.dart';
import 'package:project_menschen_fahren/models/exceptions/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for loading the JWT for the current user.
class AuthTokenProvider extends ChangeNotifier {

  static const String SSO_URL = "https://kc.myaviationapps.com/auth/realms/";
  static const String CLIENT_ID= 'login';
  static const String USER_DATA_TOKEN = 'token';
  static const String USER_DATA_REFRESH_TOKEN = 'refreshToken';
  static const String USER_DATA_EXPIRES_IN ='expiresIn';
  static const String USER_DATA='userData';
  static const String USER_DATA_REALM = 'realm';
  static const String USER_DATA_REFRESH_TOKEN_EXPIRES_DATE='refreshExpiryDate';

  static Logger log = getLogger('AuthenticationTokenProvider');

  /// Login of the current user.
  String? userLogin;

  /// Last known JWT of the current user
  String? token;

  /// The refresh token to update an expired authentication token.
  String? _refreshToken;

  /// Timer used in the automatic logout.
  Timer? _authTimer;

  /// Time of when the authentication token will expire.
  DateTime? _expiryDate;

  /// Time of when the refresh token will expire.
  DateTime? _refreshTokenExpiryDate;

  /// Sets the Access token.
  void setToken(String? token) {
    this.token = token;
    notifyListeners();
  }

  /// Returns the current bearer authentication token or null if none could be loaded.
  ///
  /// This includes a checks if the current token has expired. If expired the refresh token will be used for trying to acquire a new token.
  Future<String?> getBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    //check the user data in shared preference. Returns null if no information found in the shared preference.
    if (!prefs.containsKey(USER_DATA)) {
      setToken(null);
      log.d('No Shared Preference. Token is null');
      notifyListeners();
      return null;
    }

    final String userData = prefs.getString(USER_DATA)!;
    final extractedUserData = json.decode(userData) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData[USER_DATA_EXPIRES_IN]);

    //If access token is expired, uses refresh token to get new access token else returns the current excess token.
    if (expiryDate.isBefore(DateTime.now())) {
      log.d('Access token expired. Trying with Refresh token.');
      final refreshToken = extractedUserData[USER_DATA_REFRESH_TOKEN];
      final realm = extractedUserData[USER_DATA_REALM];

      try {
        final refreshTokenExpiryDate = DateTime.parse(extractedUserData[USER_DATA_REFRESH_TOKEN_EXPIRES_DATE]);
        // If the refresh token expiry date is before current time. Then clear the shared preference/logout.
        if(refreshTokenExpiryDate.isBefore(DateTime.now())){
          log.d('Refresh token is also expired. Clearing shared preferences.');
          //TODO: clear all shared preference or change the logic to always prefill company code and username.
          await logout();
        }else {
          log.d('Trying to get new Access token from Refresh token.');
          final AuthenticationResponse1? authResponse = await _getFromRefreshToken(
              realm, refreshToken);
          log.d('New AuthenticationResponse: $authResponse');
          setToken(authResponse!.accessToken);
        }
        notifyListeners();
      }on HttpException catch (error) {
        //TODO: this needs to be verified.
        var errorMessage = 'Authentication failed';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is too weak.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Could not find a user with that email.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password.';
        }
        //_showErrorDialog(errorMessage);
        log.d('errorMessage: $errorMessage');
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        //_showErrorDialog(errorMessage);
        log.d('errorMessage: $errorMessage');
      }

    }else{
      log.d('The old access token is working.');
      setToken(extractedUserData[USER_DATA_TOKEN]);
    }

    return Future.value(token);

  }

  /// Return of there is an authentication token.
  bool get isAuth {
    return token != null;
  }

  /// Returns if the authentication token is expired.
  Future<bool> isExpired() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(USER_DATA)) {
      return true;
    }

    final String userData = prefs.getString(USER_DATA)!;
    final extractedUserData = json.decode(userData) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData[USER_DATA_EXPIRES_IN]);

    if (expiryDate.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }

  /// Returns a new authentication token using the refresh token.
  Future<AuthenticationResponse1?> _getFromRefreshToken(String realm, String refreshToken) async{
    String url = GlobalConfig.keycloakUrl + realm + '/protocol/openid-connect/token';
    Map<String,String> headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'cache-control': 'no-cache',
    };
    Map<String,String> data = {
      'client_id': CLIENT_ID,
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken
    };
    try {
      Uri keycloakUrl = Uri.parse(url);
      http.Response response = await http.post(
          keycloakUrl, headers: headers, body: data);
      dynamic responseData = json.decode(response.body);
      log.d('responseData after refresh call: $responseData');
      if (responseData['error'] != null) {
        log.d("Error happened: $responseData['error']");
        throw HttpException(responseData['error']['error_description']);
      }
      AuthenticationResponse1 authResponse = AuthenticationResponse1.fromJson(
          responseData);
      log.d('authResponse: $authResponse');
      token = authResponse.accessToken;
      _refreshToken = authResponse.refreshToken;
      _expiryDate = DateTime.now().add(
        Duration(
            seconds: authResponse.expiresIn
        ),
      );

      _refreshTokenExpiryDate = DateTime.now().add(
        Duration(
            seconds: authResponse.refreshExpiresIn
        ),
      );

      //_autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final String userData = prefs.getString(USER_DATA)!;
      final extractedUserData = json.decode(userData) as Map<String, dynamic>;
      extractedUserData[USER_DATA_TOKEN] = token;
      extractedUserData[USER_DATA_EXPIRES_IN] = _expiryDate;
      extractedUserData[USER_DATA_REFRESH_TOKEN] = _refreshToken;
      extractedUserData[USER_DATA_REFRESH_TOKEN_EXPIRES_DATE] = _refreshTokenExpiryDate;
      prefs.setString(USER_DATA, userData);
      return authResponse;
    }catch(error){
      log.d('rethrowing error $error');
      rethrow;
    }

  }

  /// Logs the user in and load the authentication token.
  ///
  ///Returns if the login request was successful.
  Future<bool> login(String email, String password) async{
    String url = GlobalConfig.menschenFahrenServiceUrl + '/api/authenticate';
    Map<String,String> headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'cache-control': 'no-cache',
    };
    Map<String,String> data = {
      'email': email,
      'password': password,
    };
    try{
      Uri keycloakUrl = Uri.parse(url);
      http.Response response = await http.post(keycloakUrl, headers: headers, body: data);

      dynamic responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        log.d("Error while trying to login. $responseData['error']");
        throw HttpException(responseData['error']['error_description']);
      }

      AuthenticationResponse1 authResponse = AuthenticationResponse1.fromJson(responseData);
      token = authResponse.accessToken;
      _refreshToken = authResponse.refreshToken;
      userLogin = email;
      _expiryDate = DateTime.now().add(
        Duration(
            seconds: authResponse.expiresIn
        ),
      );
      _refreshTokenExpiryDate = DateTime.now().add(
        Duration(
            seconds: authResponse.refreshExpiresIn
        ),
      );
      //_autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          USER_DATA_EXPIRES_IN: _expiryDate!.toIso8601String(),
          USER_DATA_TOKEN: token,
          USER_DATA_REFRESH_TOKEN: _refreshToken,
          USER_DATA_REFRESH_TOKEN_EXPIRES_DATE: _refreshTokenExpiryDate!.toIso8601String()
        },
      );
      prefs.setString(USER_DATA, userData);
      return true;
    }catch (error) {
      rethrow;
    }
  }

  /// Tries to automatically log in the user according to the last known user details.
  Future<bool> tryAutoLogin() async {
    //logout();
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(USER_DATA)) {
      return false;
    }

    final String userData = prefs.getString(USER_DATA)!;
    final extractedUserData = json.decode(userData) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData[USER_DATA_EXPIRES_IN]);

    final now = DateTime.now();
    if (expiryDate.isBefore(now)) {
      String? newToken;
      getBearerToken().then((value) => newToken = value);
      if(newToken == null){
        return false;
      }
    }
    token = extractedUserData[USER_DATA_TOKEN];
    _refreshToken = extractedUserData[USER_DATA_REFRESH_TOKEN];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  /// Logs the current user out.
  ///
  /// Will clear the stored user details.
  Future<void> logout() async {
    token = null;
    _refreshToken = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}