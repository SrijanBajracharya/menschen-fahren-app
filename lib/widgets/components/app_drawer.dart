import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Color(0xff8BBA50),
            title: const Text('Settings'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Events'),
            onTap: () {
              if( ModalRoute.of(context)!.settings.name != RoutesName.MAIN_PAGE){
                Navigator.pushReplacementNamed(context, RoutesName.MAIN_PAGE);
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('My favorite'),
            onTap: () {
              if( ModalRoute.of(context)!.settings.name != RoutesName.FAVORITES){
                Navigator.pushReplacementNamed(context, RoutesName.FAVORITES);
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RoutesName.ROUTE_LOGIN);
              Provider.of<AuthenticationTokenProvider>(context, listen: false)
                  .logout();
            },
          ),
        ],
      ),
    );
  }
}
