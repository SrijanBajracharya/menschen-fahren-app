import 'dart:convert';

import 'package:project_menschen_fahren/logger.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';

/* Config definition used to load environment specific config. */
class AppConfig {

  /* The URL of the DataCache service. */
  String dataCacheServiceUrl;

  /* If dummy data will be generated. */
  bool useDummyData;

  String keycloakUrl;

  static Logger log = getLogger('AppConfig');

  AppConfig({required this.dataCacheServiceUrl, required this.useDummyData, required this.keycloakUrl});

  /*
   * Loads a config file from the assets named after the provided environment.
   * If null is given it defaults to 'dev'.
   */
  static Future<AppConfig> forEnvironment(String? environment) async {

    // Default to dev environment
    environment = environment ?? 'dev';

    log.i("Load configuration for environment: $environment.");

    // Load the json file from the assets.
    final contents = await rootBundle.loadString(
        'assets/config/$environment.json',
        cache: false
    );

    // decode our json
    final json = jsonDecode(contents);
    return AppConfig(
        dataCacheServiceUrl: json['dataCacheServiceUrl'],
        useDummyData: json['useDummyData'],
        keycloakUrl: json['keycloakUrl']
    );
  }
}

/* Contains global configuration. */
class GlobalConfig {

  static String dataCacheServiceUrl = 'http://localhost:8080';
  static bool useDummyData = false;
  static String keycloakUrl = '';

  /* Setup the global config based on the the provided data */
  static setup(AppConfig config) {

    GlobalConfig.dataCacheServiceUrl = config.dataCacheServiceUrl;
    GlobalConfig.useDummyData = config.useDummyData;
    GlobalConfig.keycloakUrl = config.keycloakUrl;
  }
}