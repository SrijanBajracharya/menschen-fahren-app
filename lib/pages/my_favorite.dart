import 'package:flutter/cupertino.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/models/favorites_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/event_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/helper/date_format_helper.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyFavorite extends StatefulWidget {
  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends StatefulBasePage<MyFavorite> {
  _MyFavoriteState() : super(showHamburgerMenu: false,currentIndex: 1);

  @override
  Widget buildContent(BuildContext context) {
    return MyFavoriteList();
  }

  @override
  String getTitle(BuildContext context) {
    return 'My Favorites';
  }
}

class MyFavoriteList extends StatefulWidget {
  @override
  _MyFavoriteListState createState() {
    return _MyFavoriteListState();
  }
}

class _MyFavoriteListState extends State<MyFavoriteList> {
  Future<List<MyFavoriteResponse>>? _events;

  @override
  void initState() {
    _events = _getEvents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MyFavoriteResponse>>(
      future: _events,
      builder: (BuildContext context,
          AsyncSnapshot<List<MyFavoriteResponse>> snapshot) {
        if (snapshot.hasData) {
          return _buildDataList(context, snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(context, snapshot.error);
        } else {
          return _buildLoadingWidget(context);
        }
      },
    );
  }

  /* Builds the widget shown while the Approvals are loading. */
  Widget _buildLoadingWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            child: CircularProgressIndicator(),
            height: 80,
            width: 80,
          ),
          // Show a loading text
          Text('Loading')
        ],
      ),
    );
  }

  /* Widget show in case of an error. */
  Widget _buildErrorWidget(BuildContext context, Object? error) {
    return Center(
      // TODO better text
      child: Text("Error: " + error!.toString()),
    );
  }

  Widget _buildDataList(
      BuildContext context, List<MyFavoriteResponse>? events) {
    List<Widget> widgets = List.empty(growable: true);
    List<MyFavoriteResponse> allEvents = List.empty(growable: true);
    if (events != null) {
      allEvents.addAll(events);
    }

    widgets.addAll(_buildListCells(context, allEvents));

    if (widgets.isEmpty) {
      // TODO l10n
      widgets.add(Text("You dont have favorite events"));
    }
    return ListView(children: widgets, padding: const EdgeInsets.all(30));
  }

  /* Build list cells for all the given Approvals. */
  List<Widget> _buildListCells(
      BuildContext context, List<MyFavoriteResponse> approvals) {
    List<Widget> widgets = List.empty(growable: true);

    for (int index = 0; index < approvals.length; index++) {
      widgets.add(_buildListCell(context, approvals[index], index));
    }
    return widgets;
  }

  /* Builds a cell for one entry of the list. */
  Widget _buildListCell(
      BuildContext context, MyFavoriteResponse data, int index) {
    return InkWell(
        onTap: () => _tapCell(context, data),
        child: Padding(
          padding: const EdgeInsets.only( bottom: 10),
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
                          Container(
                            width: 200,
                            child: Text(
                              data.event.name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FavoriteButton(
                            isFavorite: false,
                            // iconDisabledColor: Colors.white,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                            },
                          ),
                        ],
                      ),
                      subtitle: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.event.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ))),
                  UiHelper.buildDividerWithIndent(
                      startIndent: 20, endIndent: 20),
                  ListTile(
                    title: Text(
                      'Events Info: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Event Date: ${DateHelper.formatDate(data.event.startDate)}',
                          style: TextStyle(
                              fontSize: 14,
                          ),
                        ),
                        Text(
                          'Group: ${data.event.numberOfParticipants}',
                          style: TextStyle(
                              fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  /* Tap the cell to open the details page. */
  void _tapCell(BuildContext context, MyFavoriteResponse data) {
    Navigator.of(context)
        .pushReplacementNamed(RoutesName.EVENT_DESCRIPTION, arguments: data);
  }

  Future<List<MyFavoriteResponse>> _getEvents() async {
    print('inside getEvents..');
    try {
      AuthenticationTokenProvider tokenProvider =
          Provider.of<AuthenticationTokenProvider>(context, listen: false);

      EventService service = EventService();

      String? authenticationToken = await tokenProvider.getBearerToken();

      print('$authenticationToken <- authToken is this');
      if (authenticationToken != null) {
        final List<MyFavoriteResponse> events = await service.getFavoriteEvents(
            authenticationToken, "456be2e3-4ebc-41c4-a129-cf8862f5c958");
        print('events: $events');
        return events;
      } else {
        return Future.error(
            "Error loading authentication token. Please log in again.");
      }
    } catch (error) {
      return Future.error("Exception occurred $error.");
    }
  }
}
