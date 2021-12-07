import 'dart:async';
import 'dart:convert';
import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/logger.dart';
import 'package:project_menschen_fahren/models/data_cache_entry.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/*
 * Service to load cache entries from the REST service.
 */
class CacheService {

  static Logger log = getLogger('CacheService');

  static const String URL_GET_ENTRIES_ENDPOINT = "/entries";
  static const String URL_GET_ENTRY_ENDPOINT = "/entry";

  /* Builds the header with the authentication token. */
  Map<String,String> _buildHeader(String authenticationToken) {

    return {
      'Authorization' : 'Bearer ' + authenticationToken,
      "Access-Control-Allow-Origin": "*"
    };
  }

  /* Returns the DataCache entries according to the provided filter. */
  Future<List<DataCacheEntry>> getDataCacheEntries(String authenticationToken, String type, String? filter) async {
      return _fetchDataCacheEntries(authenticationToken,type, filter);
  }

  /* Returns a DataCacheEntry for the provided ID. */
  Future<DataCacheEntry?> getDataCacheEntry(String authenticationToken, String type, String entryId) async {

    return _fetchDataCacheEntry(authenticationToken, entryId);
  }

  /* Returns DataCacheEntries from the service. */
  Future<List<DataCacheEntry>> _fetchDataCacheEntries(String authenticationToken, String type, String? filter) async {

    // create a URL based on the configured url and known endpoint that contains the parameters.
    Uri serverAddress = Uri.parse(GlobalConfig.dataCacheServiceUrl + URL_GET_ENTRIES_ENDPOINT).replace(queryParameters: {
      'entryTypeCode' : type,
      'filterCriteria' : filter
    });

    http.Response response;
    try {

      log.i("Fetch DataCacheEntry from server address: " + serverAddress.path);
      response = await http.get(serverAddress, headers: _buildHeader(authenticationToken));

    } catch(e) {

      log.e("Exception when trying to read DataCacheEntities: $e");
      return Future.error(e);
    }

    if (response.statusCode == 200) {

      try {

        //Read the "data" field from the response for the list of DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        // TODO maybe make it more stable for cases if only one of them fails to parse.
        return DataCacheEntry.listFromJson(jsonData['data']);

      } catch (e) {

        log.e("Error parsing the response: $e");
        return Future.error(e);
      }

    } else if(response.statusCode == 204) {

      // Simply return empty list in case of 204.
      log.d("Received a 204 from the cache service");
      return List.empty();

    } else {

      String errorResponse = _handleErrorResponse(response, "dataCacheEntry");
      return Future.error(errorResponse);
    }
  }

  /* Fetch a DataCacheEntry from the service. */
  Future<DataCacheEntry?> _fetchDataCacheEntry(String authenticationToken, String entryId) async {

    // create a URL based on the configured url and known endpoint that already contains the parameters.
    Uri serverAddress = Uri(
      path: GlobalConfig.dataCacheServiceUrl + URL_GET_ENTRY_ENDPOINT,
      queryParameters: {
        'dataCacheEntryId' : entryId
      },
    );

    try {

      final DataCacheEntry? result;
      http.Response response = await http.get(
          serverAddress, headers: _buildHeader(authenticationToken));

      if(response.statusCode == 200) {

        //Read the "data" field from the response for DataCacheEntry.
        final jsonData = jsonDecode(response.body);
        result = DataCacheEntry.fromJson(jsonData['data']);

      } else if(response.statusCode == 204) {

        // Simply return null in case of 204.
        return null;

      } else {

        String errorResponse = _handleErrorResponse(response, "dataCacheEntry");
        return Future.error(errorResponse);
      }

      return result;

    } catch(e) {
      log.e("Error when calling service: $e");
      return Future.error(e);
    }
  }

  /* Handle the response in an error case and returns an error description. */
  String _handleErrorResponse(http.Response response, String requestName) {

    log.e("Received error code \"" + response.statusCode.toString() +"\" from service wen loading multiple entities: " + response.toString());

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