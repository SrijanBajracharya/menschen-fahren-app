import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_menschen_fahren/models/friends_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/user_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:provider/provider.dart';

class Friend extends StatefulWidget {
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends StatefulBasePage<Friend> {
  _FriendState() : super(showHamburgerMenu: false,currentIndex: 4,showBackButton: true, routeBackTo: RoutesName.PROFILE);

  Future<List<FriendResponse>>? _friends;

  @override
  void initState() {
    _friends = _getFriends();

    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return FutureBuilder<List<FriendResponse>>(
      future: _friends,
      builder:
          (BuildContext context, AsyncSnapshot<List<FriendResponse>> snapshot) {
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

  Widget _buildDataList(BuildContext context, List<FriendResponse>? events) {
    print('length: $events!.length');
    List<Widget> widgets = List.empty(growable: true);
    List<FriendResponse> allFriends = List.empty(growable: true);
    if (events != null) {
      allFriends.addAll(events);
    }

    widgets.addAll(_buildListCells(context, allFriends));

    if (widgets.isEmpty) {
      // TODO l10n
      widgets.add(Text('No Friends Found'));
    }
    return ListView(children: widgets, padding: const EdgeInsets.all(30));
  }

  /* Build list cells for all the given Approvals. */
  List<Widget> _buildListCells(
      BuildContext context, List<FriendResponse> approvals) {
    List<Widget> widgets = List.empty(growable: true);

    for (int index = 0; index < approvals.length; index++) {
      widgets.add(_buildListCell(context, approvals[index], index));
    }
    return widgets;
  }

  /* Builds a cell for one entry of the list. */
  Widget _buildListCell(BuildContext context, FriendResponse data, int index) {
    return InkWell(
        onTap: () => _tapCell(context, data),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
              borderOnForeground: true,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  /*Container(
                    child: Image.asset('assets/images/city.jpg'),
                  ),*/
                  ListTile(
                      contentPadding: EdgeInsets.all(16),

                      subtitle: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: UiHelper.buildCustomCircleAvatar(assetName: 'assets/images/city.jpg', outerRadius: 30, innerRadius: 28),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${data.firstName} ${data.lastName}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                data.username,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                data.email,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),

                ],
              )),
        ));
  }

  void _tapCell(BuildContext context, FriendResponse data) {
    //Navigator.of(context)
     //   .pushReplacementNamed(RoutesName.EVENT_DESCRIPTION, arguments: data);
  }

  @override
  String getTitle(BuildContext context) {
    return 'Friends';
  }

  Future<List<FriendResponse>> _getFriends() async {
    print('inside getEvents..');
    try {
      AuthenticationTokenProvider tokenProvider =
      Provider.of<AuthenticationTokenProvider>(context, listen: false);

      UserService service = UserService();

      String? authenticationToken = await tokenProvider.getBearerToken();

      if (authenticationToken != null) {
        final List<FriendResponse> events =
        await service.getFriendsByUserId(authenticationToken);
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