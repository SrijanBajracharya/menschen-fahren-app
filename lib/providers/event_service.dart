import 'dart:convert';
import 'dart:math';

import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/models/event_edit_request.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:http/http.dart' as http;
import 'package:project_menschen_fahren/models/favorites_response.dart';

class EventService{

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
  Future<List<EventResponse>> getEventResponse(String authenticationToken, bool alsoVoided,bool alsoPrivate) async {
      return _fetchEvents(authenticationToken,alsoVoided, alsoPrivate);

  }

  /* Returns DataCacheEntries from the service. */
  Future<List<EventResponse>> _fetchEvents(String authenticationToken,bool alsoVoided,bool alsoPrivate) async {

    print('i am here...... $alsoVoided $alsoPrivate');
    // create a URL based on the configured url and known endpoint that contains the parameters.
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/events?voided=$alsoVoided&alsoPrivate=$alsoPrivate');

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
        return EventResponse.listFromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    } else if(response.statusCode == 204) {
      return List.empty();

    } else {

      String errorResponse = _handleErrorResponse(response, "getEvents");
      return Future.error(errorResponse);
    }
  }

  /* Returns DataCacheEntries from the service. */
  Future<List<EventResponse>> getMyEvents(String authenticationToken) async {


    // create a URL based on the configured url and known endpoint that contains the parameters.
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/events/user');

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
        return EventResponse.listFromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    } else if(response.statusCode == 204) {
      return List.empty();

    } else {

      String errorResponse = _handleErrorResponse(response, "getMyEvents");
      return Future.error(errorResponse);
    }
  }

  /* Returns the DataCache entries according to the provided filter. */
  Future<List<MyFavoriteResponse>> getFavoriteEvents(String authenticationToken) async {
    // create a URL based on the configured url and known endpoint that contains the parameters.
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/favorites');

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
        return MyFavoriteResponse.listFromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    } else if(response.statusCode == 204) {
      return List.empty();

    } else {

      String errorResponse = _handleErrorResponse(response, "getEvents");
      return Future.error(errorResponse);
    }

  }

  Future<EventResponse> createEvent(String authenticationToken, Map<String,String> data) async {

    print(data);

    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/events');
    print(serverAddress);
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
        return EventResponse.fromJson(jsonData['data']);

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