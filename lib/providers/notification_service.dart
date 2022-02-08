import 'dart:convert';
import 'dart:math';

import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/models/event_edit_request.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:http/http.dart' as http;
import 'package:project_menschen_fahren/models/favorites_response.dart';
import 'package:project_menschen_fahren/models/notification_response.dart';

class NotificationService{

  /* Builds the header with the authentication token. */
  Map<String,String> _buildHeader(String authenticationToken) {

    return {
      'Authorization' : 'Bearer ' + authenticationToken,
      "Access-Control-Allow-Origin": "*",
      "content-type" : "application/json",
      "accept" : "application/json",
    };
  }

  /* Returns the DataCache entries according to the provided filter. */
  Future<List<NotificationResponse>> getNotifications(String authenticationToken, bool alsoVoided) async {
    return _fetchNotification(authenticationToken,alsoVoided);

  }

  /* Returns DataCacheEntries from the service. */
  Future<List<NotificationResponse>> _fetchNotification(String authenticationToken,bool alsoVoided) async {

    // create a URL based on the configured url and known endpoint that contains the parameters.
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/notification?voided=$alsoVoided');

    print('serverAddress: $serverAddress');
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
        return NotificationResponse.listFromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    } else if(response.statusCode == 204) {
      return List.empty();

    } else {

      String errorResponse = _handleErrorResponse(response, "getNotification");
      return Future.error(errorResponse);
    }
  }



  Future<NotificationResponse> createNotification(String authenticationToken, Map<String,String> data) async {
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/notification/invite');
    http.Response response;
    try {
      response = await http.post(serverAddress, headers: _buildHeader(authenticationToken), body: jsonEncode(data));
      print(response.body);
    } catch(e) {
      return Future.error(e);
    }

    if (response.statusCode == 201) {

      try {

        //Read the "data" field from the response for the list of DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        // TODO maybe make it more stable for cases if only one of them fails to parse.
        return NotificationResponse.fromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    }  else {

      String errorResponse = _handleErrorResponse(response, "createUser");
      return Future.error(errorResponse);
    }

  }


  Future<NotificationResponse> updateNotification(String authenticationToken,String notificationId,String originalSenderId, Map<String,String> data) async {
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/notification/$notificationId/sender/$originalSenderId');
    http.Response response;
    try {
      response = await http.patch(serverAddress, headers: _buildHeader(authenticationToken), body: jsonEncode(data));
      print(response.body);
    } catch(e) {
      return Future.error(e);
    }

    if (response.statusCode == 200) {

      try {

        //Read the "data" field from the response for the list of DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        // TODO maybe make it more stable for cases if only one of them fails to parse.
        return NotificationResponse.fromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    }  else {

      String errorResponse = _handleErrorResponse(response, "createUser");
      return Future.error(errorResponse);
    }

  }

  /* Handle the response in an error case and returns an error description. */
  String _handleErrorResponse(http.Response response, String requestName) {

    switch(response.statusCode) {
      case 400:
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