import 'package:favorite_button/favorite_button.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/event_response.dart';
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StatefulBasePage<Home> {
  _HomeState() : super(true);

  @override
  Widget buildContent(BuildContext context) {
    return EventList();
  }

  @override
  String getTitle(BuildContext context) {
    return 'Events';
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() {
    return _EventListState();
  }
}

class _EventListState extends State<EventList> {
  Future<List<EventResponse>>? _events;

  @override
  void initState() {
    _events = _getEvents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventResponse>>(
      future: _events,
      builder:
          (BuildContext context, AsyncSnapshot<List<EventResponse>> snapshot) {
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

  Widget _buildDataList(BuildContext context, List<EventResponse>? events) {
    print('length: $events!.length');
    List<Widget> widgets = List.empty(growable: true);
    List<EventResponse> allEvents = List.empty(growable: true);
    if (events != null) {
      allEvents.addAll(events);
    }

    widgets.addAll(_buildListCells(context, allEvents));

    if (widgets.isEmpty) {
      // TODO l10n
      widgets.add(Text('No Events Found'));
    }
    return ListView(children: widgets, padding: const EdgeInsets.all(30));
  }

  /* Build list cells for all the given Approvals. */
  List<Widget> _buildListCells(
      BuildContext context, List<EventResponse> approvals) {
    List<Widget> widgets = List.empty(growable: true);

    for (int index = 0; index < approvals.length; index++) {
      widgets.add(_buildListCell(context, approvals[index], index));
    }
    return widgets;
  }

  /* Builds a cell for one entry of the list. */
  Widget _buildListCell(BuildContext context, EventResponse data, int index) {
    return InkWell(
        onTap: () => _tapCell(context, data),
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
                          Container(
                            width: 200,
                            child: Text(
                              data.name,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  fontFamily: Constants.PRIMARY_FONT_FAMILY,
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
                              data.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: Constants.PRIMARY_FONT_FAMILY,
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
                          fontFamily: Constants.PRIMARY_FONT_FAMILY,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Event Date: ${DateHelper.formatDate(data.startDate)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Constants.PRIMARY_FONT_FAMILY,
                          ),
                        ),
                        Text(
                          'Group: ${data.numberOfParticipants}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Constants.PRIMARY_FONT_FAMILY),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  /* Tap the cell to open the details page. */
  void _tapCell(BuildContext context, EventResponse data) {
    Navigator.of(context)
        .pushReplacementNamed(RoutesName.EVENT_DESCRIPTION, arguments: data);
  }

  Future<List<EventResponse>> _getEvents() async {
    print('inside getEvents..');
    try {
      AuthenticationTokenProvider tokenProvider =
          Provider.of<AuthenticationTokenProvider>(context, listen: false);

      EventService service = EventService();

      String? authenticationToken = await tokenProvider.getBearerToken();

      print('$authenticationToken <- authToken is this');
      if (authenticationToken != null) {
        final List<EventResponse> events =
            await service.getEventResponse(authenticationToken, false, false);
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
