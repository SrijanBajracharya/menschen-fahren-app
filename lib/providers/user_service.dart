import 'dart:convert';

import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/models/exceptions/http_exception.dart';
import 'package:project_menschen_fahren/models/friends_response.dart';
import 'package:project_menschen_fahren/models/user_profile_response.dart';
import 'package:project_menschen_fahren/models/user_response.dart';
import 'package:http/http.dart' as http;

class UserService{

  /* Builds the header with the authentication token. */
  Map<String,String> _buildHeader(String authenticationToken) {

    return {
      'Authorization' : 'Bearer ' + authenticationToken,
      "Access-Control-Allow-Origin": "*"
    };
  }

  Map<String,String> _buildHeaderWithoutAuthToken() {

    return {
      "Access-Control-Allow-Origin": "*",
      "content-type" : "application/json",
      "accept" : "application/json",
    };
  }



  /* Returns the DataCache entries according to the provided filter. */
  Future<UserResponse> createUser(Map<String, String> data) async {

      Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/user');
      http.Response response;
      try {
        response = await http.post(serverAddress, headers: _buildHeaderWithoutAuthToken(), body: jsonEncode(data));
        print(response.body);
      } catch(e) {
        return Future.error(e);
      }

      if (response.statusCode == 201) {

        try {

          //Read the "data" field from the response for the list of DataCacheEntry.
          final jsonData = jsonDecode(response.body);
          // TODO maybe make it more stable for cases if only one of them fails to parse.
          return UserResponse.fromJson(jsonData['data']);

        } catch (e) {
          return Future.error(e);
        }

      }if(response.statusCode == 400){
        return Future.error('Username already exists');
      }
      else {

        String errorResponse = _handleErrorResponse(response, "createUser");
        return Future.error(errorResponse);
      }

  }

  Future<UserProfileResponse> getUserProfileByUserId(String authenticationToken,String userId, bool alsoVoided) async {
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/userProfile/userId/$userId?voided=$alsoVoided');
    http.Response response;
    try {
      response = await http.get(serverAddress, headers: _buildHeader(authenticationToken));
      print(response.body);
    } catch(e) {
      return Future.error(e);
    }

    if (response.statusCode == 200) {

      try {

        //Read the "data" field from the response for the list of DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        // TODO maybe make it more stable for cases if only one of them fails to parse.
        return UserProfileResponse.fromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    }  else {

      String errorResponse = _handleErrorResponse(response, "getUserProfile");
      return Future.error(errorResponse);
    }
  }

  Future<UserProfileResponse> getUserProfile(String authenticationToken, bool alsoVoided) async {
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/userProfile?voided=$alsoVoided');
    http.Response response;
    try {
      response = await http.get(serverAddress, headers: _buildHeader(authenticationToken));
      print(response.body);
    } catch(e) {
      return Future.error(e);
    }

    if (response.statusCode == 200) {

      try {

        //Read the "data" field from the response for the list of DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        // TODO maybe make it more stable for cases if only one of them fails to parse.
        return UserProfileResponse.fromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    }  else {

      String errorResponse = _handleErrorResponse(response, "getUserProfile");
      return Future.error(errorResponse);
    }
  }


  Future<List<FriendResponse>> getFriendsByUserId(String authenticationToken) async {
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/user/friends');
    http.Response response;
    try {
      response = await http.get(serverAddress, headers: _buildHeader(authenticationToken));
      print(response.body);
    } catch(e) {
      return Future.error(e);
    }

    if (response.statusCode == 200) {

      try {

        //Read the "data" field from the response for the list of DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        // TODO maybe make it more stable for cases if only one of them fails to parse.
        return FriendResponse.listFromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    }  else {

      String errorResponse = _handleErrorResponse(response, "getFriends");
      return Future.error(errorResponse);
    }
  }


  /* Handle the response in an error case and returns an error description. */
  String _handleErrorResponse(http.Response response, String requestName) {
    print(response.statusCode);
    switch(response.statusCode) {
      case 400:
        return "Invalid data";
      case 401:
        return "Authentication token error";
      case 403:
        return "Insufficient rights";
      case 404:
        return "Resource not found";

      default:
        return "General server error: " + response.statusCode.toString();
    }
  }
}