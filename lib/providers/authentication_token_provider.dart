import 'dart:async';
import 'dart:convert';

import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/logger.dart';
import 'package:project_menschen_fahren/models/auth_response.dart';
import 'package:project_menschen_fahren/models/exceptions/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for loading the JWT for the current user.
class AuthenticationTokenProvider extends ChangeNotifier {

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

  /// Sets the Access token.
  void setToken(String? token) {
    this.token = token;
    notifyListeners();
  }

  Future<String?> getBearerToken() async{
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(USER_DATA_TOKEN)) {
      return null;
    }else{

      final DateTime expiryDate = DateTime.parse(prefs.getString(USER_DATA_EXPIRES_IN)!);
      DateTime now = DateTime.now();
      if(now.isAfter(expiryDate)){
        await logout();
        return null;
      }
      final String userData = prefs.getString(USER_DATA_TOKEN)!;
      //final extractedUserData = json.decode(userData) as Map<String, dynamic>;

      //String userToken = extractedUserData[USER_DATA_TOKEN];
      return userData;
    }
  }

  /// Return of there is an authentication token.
  bool get isAuth {
    return token != null;
  }

  /// Returns if the authentication token is expired.
  Future<bool> isExpired() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(USER_DATA)) {
      await logout();
    }else{
      final String userData = prefs.getString(USER_DATA)!;
    }

    final String userData = prefs.getString(USER_DATA)!;
    final extractedUserData = json.decode(userData) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData[USER_DATA_EXPIRES_IN]);

    if (expiryDate.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }



  /// Logs the user in and load the authentication token.
  ///
  ///Returns if the login request was successful.
  Future<bool> login(String email, String password) async{
    print('$email $password');
    String url = GlobalConfig.menschenFahrenServiceUrl + '/api/authenticate';
    Map<String,String> headers = {
      //'content-type': 'application/x-www-form-urlencoded',
      //'content-type': 'application/json',
    //'cache-control': 'no-cache',
      "content-type" : "application/json",
      "accept" : "application/json",
    };
    Map<String,String> data = {
      'email': email,
      'password': password,
    };
    try{
      print(url);

      Uri serviceUrl = Uri.parse(url);
      http.Response response = await http.post(serviceUrl, headers: headers, body: json.encode(data));
      dynamic responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        log.d("Error while trying to login. $responseData['error']");
        throw HttpException(responseData['error']['error_description']);
      }

      AuthenticationResponse authResponse = AuthenticationResponse.fromJson(responseData['data']);

      token = authResponse.accessToken;

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          USER_DATA_TOKEN: token,
        },
      );
      prefs.setString(USER_DATA_TOKEN, token!);
      prefs.setString(USER_DATA_EXPIRES_IN, authResponse.expiryDate.toIso8601String());
      return true;
    }catch (error) {
      rethrow;
    }
  }

  /// Tries to automatically log in the user according to the last known user details.
  Future<bool> tryAutoLogin() async {
    //logout();
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(USER_DATA_TOKEN)) {
      return false;
    }

    final String userToken = prefs.getString(USER_DATA_TOKEN)!;
    final DateTime expiryDate = DateTime.parse(prefs.getString(USER_DATA_EXPIRES_IN)!);
    //final extractedUserData = json.decode(userData) as Map<String, dynamic>;

    //String userToken = extractedUserData[USER_DATA_TOKEN];

    print(expiryDate);
    DateTime now = DateTime.now();
    if(now.isAfter(expiryDate)){
      await logout();
    }
    notifyListeners();
    return true;
  }

  /// Logs the current user out.
  ///
  /// Will clear the stored user details.
  Future<void> logout() async {
    token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}