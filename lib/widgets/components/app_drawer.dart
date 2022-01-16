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
            title: const Text('Settings',style: TextStyle(color: Colors.black87),),
            automaticallyImplyLeading: false,
            elevation: 0,
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
