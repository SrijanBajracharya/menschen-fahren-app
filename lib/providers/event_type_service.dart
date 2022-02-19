import 'dart:convert';
import 'dart:math';

import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/models/create_favorite_response.dart';
import 'package:project_menschen_fahren/models/event_edit_request.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:http/http.dart' as http;
import 'package:project_menschen_fahren/models/event_type_response.dart';
import 'package:project_menschen_fahren/models/favorites_response.dart';

class EventTypeService{

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
  Future<List<EventTypeDtoResponse>> getEventTypeResponse(String authenticationToken) async {
    return _fetchEventTypes(authenticationToken);

  }

  /* Returns DataCacheEntries from the service. */
  Future<List<EventTypeDtoResponse>> _fetchEventTypes(String authenticationToken) async {
    // create a URL based on the configured url and known endpoint that contains the parameters.
    Uri serverAddress = Uri.parse(GlobalConfig.menschenFahrenServiceUrl + '/api/eventTypes');
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
        return EventTypeDtoResponse.listFromJson(jsonData['data']);

      } catch (e) {
        return Future.error(e);
      }

    } else if(response.statusCode == 204) {
      return List.empty();

    } else {

      String errorResponse = _handleErrorResponse(response, "getEventTypes");
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