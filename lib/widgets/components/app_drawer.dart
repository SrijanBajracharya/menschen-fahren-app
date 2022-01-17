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
            backgroundColor: Colors.white,
            title: _getDefaultStyle('Profile'),
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: _getDefaultStyle('Settings'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RoutesName.SETTINGS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: _getDefaultStyle('Logout'),
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

  Widget _getDefaultStyle(String title){
    return Text(title,style: TextStyle(color: Colors.black87,fontSize: 18),);
  }
}
