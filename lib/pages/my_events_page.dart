import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/event_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/helper/date_format_helper.dart';
import 'package:provider/provider.dart';

class MyEventsPage extends StatefulWidget {
  @override
  _MyEventsPage createState() => _MyEventsPage();
}

class _MyEventsPage extends StatefulBasePage<MyEventsPage> {
  _MyEventsPage() : super(showHamburgerMenu: false, currentIndex: 2);

  Future<List<EventResponse>>? _myEvents;

  @override
  void initState() {
    _myEvents = _getMyEvents();

    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return FutureBuilder<List<EventResponse>>(
      future: _myEvents,
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
    List<Widget> widgets = List.empty(growable: true);
    List<EventResponse> allFriends = List.empty(growable: true);
    if (events != null) {
      allFriends.addAll(events);
    }

    widgets.addAll(_buildListCells(context, allFriends));

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
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:15,right: 15,top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (data.private ==true) ?
                        Text(
                          'Private Event',
                        ): Text('Public Event'),
                        Text(
                          ''
                        )
                      ],
                    )
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(data.name),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Date: ${DateHelper.formatDate(data.startDate)}'),
                        if(DateTime.now().isBefore(data.startDate))Text(
                            'Upcoming'
                        )else Text('Completed')
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  void _tapCell(BuildContext context, EventResponse data) {
    Navigator.of(context)
       .pushReplacementNamed(RoutesName.EVENT_DESCRIPTION, arguments: data);
  }

  Future<List<EventResponse>> _getMyEvents() async {
    try {
      AuthenticationTokenProvider tokenProvider =
      Provider.of<AuthenticationTokenProvider>(context, listen: false);

      EventService service = EventService();

      String? authenticationToken = await tokenProvider.getBearerToken();

      if (authenticationToken != null) {
        final List<EventResponse> events =
        await service.getMyEvents(authenticationToken);
        return events;
      } else {
        return Future.error(
            "Error loading authentication token. Please log in again.");
      }
    } catch (error) {
      return Future.error("Exception occurred $error.");
    }
  }

  @override
  String getTitle(BuildContext context) {
    return "My Events";
  }
}
