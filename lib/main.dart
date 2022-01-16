import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/providers/aircraft_provider.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/maint_log_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'route_generator.dart';

void main() async{
  // ensure that it is initialized to allow access to the assets
  WidgetsFlutterBinding.ensureInitialized();

  final AppConfig config = await AppConfig.forEnvironment("dev");
  runApp(MyApp(config: config,));
}

class MyApp extends StatelessWidget {

  ///loads config and setup the global config.
  MyApp({required AppConfig config ,Key? key}) : super(key: key) {
    GlobalConfig.setup(config);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:AircraftProvider()),
        //ChangeNotifierProvider.value(value: MaintLogProvider()),
        ChangeNotifierProvider.value(
          value: AuthenticationTokenProvider(),
        ),
      ],
      child: Consumer<AuthenticationTokenProvider>(
        builder: (ctx, auth, _) =>
            MaterialApp(
              title: 'Aircraft Fleetview',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'EN'), // English, no country code
                Locale('de', 'DE'), // German, no country code
              ],
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.white,
                  backgroundColor: Color(0xFFFBFBFB),
                  fontFamily: Constants.PRIMARY_FONT_FAMILY
              ),
              //initialRoute: RoutesName.ROUTE_REGISTRATION,
              onGenerateRoute: (RouteSettings settings) =>
                  RouteGenerator.buildRoute(settings,auth),
            ),
      ),

    );
  }

}
