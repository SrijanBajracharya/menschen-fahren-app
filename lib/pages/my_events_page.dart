import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEventsPage extends StatefulWidget {
  @override
  _MyEventsPage createState() => _MyEventsPage();
}

class _MyEventsPage extends StatefulBasePage<MyEventsPage> {
  _MyEventsPage() : super(true);

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
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Pokhara Trip'),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Date: 13.03.2021'),
                                Text('Upcoming')
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
    return "My Events";
  }
}
