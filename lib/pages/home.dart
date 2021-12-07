import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StatefulBasePage<Home> {
  _HomeState() : super(true);

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: (ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
                //TODO: onTap
                child: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: Card(
                  borderOnForeground: true,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/city.jpg'),
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(16),
                          title: Text(
                            'Lisbon, Portugal',
                          ),
                          subtitle: Container(
                              child: Column(
                            children: <Widget>[
                              Text(
                                  'Sea side area in Lisbon, Portugal with beautiful view of hill.'),
                            ],
                          ))),
                      Divider(
                        color: Color(0xff8BBA50),
                        thickness: 1.4,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        title: Text('Events Info: '),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Event Date:'),
                            Text('Group: ')
                          ],
                        ),
                      )
                    ],
                  )),
            ));
          },
        )),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  String getTitle(BuildContext context) {
    return "Events";
  }
}
