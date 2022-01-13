
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:project_menschen_fahren/logger.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/models/maint_log_type.dart';
import 'package:project_menschen_fahren/pages/ac_status.dart';
import 'package:project_menschen_fahren/pages/login_page.dart';
import 'package:project_menschen_fahren/pages/edit_profile.dart';
import 'package:project_menschen_fahren/pages/error_page.dart';
import 'package:project_menschen_fahren/pages/event_description.dart';
import 'package:project_menschen_fahren/pages/fleet_status.dart';
import 'package:project_menschen_fahren/pages/my_events_page.dart';
import 'package:project_menschen_fahren/pages/my_favorite.dart';
import 'package:project_menschen_fahren/pages/profile.dart';
import 'package:project_menschen_fahren/pages/registration_page.dart';
import 'package:project_menschen_fahren/pages/splash_screen.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'pages/delays.dart';
import 'pages/create_event_page.dart';
import 'pages/home.dart';
import 'routes_name.dart';

class RouteGenerator {

  static Logger log = getLogger('RouteGenerator');

  static Route<dynamic> buildRoute(RouteSettings settings,AuthenticationTokenProvider auth){

    // TODO correct error behavior, especially if the data isn't in the Route
    // TODO Login expired behavior? Or not needed?
    if(!auth.isAuth){
      log.d("The user is not authenticated. Trying to autologin.");
      return MaterialPageRoute(builder: (BuildContext context) =>
          FutureBuilder<bool>(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
                _navigate(ctx,authResultSnapshot, settings
                ),
          ),
          settings: const RouteSettings(name: RoutesName.ROUTE_REGISTRATION)
      );
    }else{
      return _generateRoute(settings);
    }
  }

  static Widget _navigate(BuildContext ctx, AsyncSnapshot snapshot,RouteSettings settings){
    if(snapshot.hasData) {
      if(snapshot.data){
        return _generateRoute(settings).builder.call(ctx);
      }else{
        return LoginPage();
      }
    } else if (snapshot.hasError) {
      return LoginPage();
    } else {
      return const SplashScreen();
    }
  }

  /// Routes to different Pages based on the name.
  static MaterialPageRoute _generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesName.ROUTE_DEFAULT:
      case RoutesName.ROUTE_LOGIN:
        return _buildLoginPageRoute();

      case RoutesName.ROUTE_REGISTRATION:
        return _buildRegistrationPageRoute();

      case RoutesName.MAIN_PAGE:
        return MaterialPageRoute(
            builder: (_) => Home(),
            settings: const RouteSettings(name: RoutesName.MAIN_PAGE)
        );

      case RoutesName.FLEET_STATUS:
        return MaterialPageRoute(
            builder: (_) => FleetStatus(),
            settings: const RouteSettings(name: RoutesName.FLEET_STATUS)
        );

      case RoutesName.EVENT_DESCRIPTION:
        if (args is EventResponse) {
          return MaterialPageRoute(
              builder: (_) => EventDescription(data: args,),
              settings: const RouteSettings(name: RoutesName.EVENT_DESCRIPTION)
          );
        }
        break;


      case RoutesName.DELAYS:
        return MaterialPageRoute(
            builder: (_) => Delays(true),
            settings: const RouteSettings(name: RoutesName.DELAYS)
        );

      case RoutesName.CREATE_EVENT:
        return MaterialPageRoute(
            builder: (_) => CreateEvent(),
            settings: const RouteSettings(name: RoutesName.CREATE_EVENT)
        );

      case RoutesName.AC_STATUS:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => Profile(),
              settings: const RouteSettings(name: RoutesName.AC_STATUS)
          );
        }
        break;

      case RoutesName.ITEM_DETAILS:
        return MaterialPageRoute(builder: (_) => MyEventsPage());

      case RoutesName.FAVORITES:
        return MaterialPageRoute(
            builder: (_) => MyFavorite(),
            settings: const RouteSettings(name: RoutesName.FAVORITES)
        );

      case RoutesName.PROFILE:
        return MaterialPageRoute(
            builder: (_) => Profile(),
            settings: const RouteSettings(name: RoutesName.PROFILE)
        );

      case RoutesName.EDIT_PROFILE:
        return MaterialPageRoute(
            builder: (_) => EditProfile(),
            settings: const RouteSettings(name: RoutesName.EDIT_PROFILE)
        );

      default:
        return _errorRoute();
    }

    return _errorRoute();
  }

  static MaterialPageRoute _errorRoute() {
    return MaterialPageRoute(builder: (_) => ErrorPage(),
        settings: const RouteSettings(name: RoutesName.ERROR)
    );
  }

  static MaterialPageRoute _buildLoginPageRoute() {
    return MaterialPageRoute(
        builder: (context) => const LoginPage() ,
        settings: const RouteSettings(name: RoutesName.ROUTE_LOGIN)
    );
  }

  static MaterialPageRoute _buildRegistrationPageRoute() {
    return MaterialPageRoute(
        builder: (context) => const RegistrationPage() ,
        settings: const RouteSettings(name: RoutesName.ROUTE_REGISTRATION)
    );
  }
}
