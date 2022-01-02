import 'package:favorite_button/favorite_button.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:google_fonts/google_fonts.dart';

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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Lisbon, Portugal',style: TextStyle(
                                fontFamily: "Open sans",
                              ),),
                              FavoriteButton(
                                isFavorite: true,
                                // iconDisabledColor: Colors.white,
                                valueChanged: (_isFavorite) {
                                  print('Is Favorite : $_isFavorite');
                                },
                              ),
                            ],
                          ),
                          subtitle: Container(
                              child: Column(
                            children: <Widget>[
                              Text(
                                'Sea side area in Lisbon, Portugal with beautiful view of hill.',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: GoogleFonts.openSans(fontSize: 16,fontStyle: FontStyle.normal),
                                /*style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                ),*/
                              ),
                            ],
                          ))),
                      UiHelper.buildDividerWithIndent(
                          startIndent: 20, endIndent: 20),
                      ListTile(
                        title: Text('Events Info: '),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Event Date:',style: TextStyle(
                              fontSize: 14,
                            ),
                            ),
                            Text('Group: ',style: TextStyle(
                              fontSize: 14,
                            ),)
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
