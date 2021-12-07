import 'dart:async';
import 'dart:developer' as developer;

import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/aircraft_type.dart';
import 'package:project_menschen_fahren/providers/aircraft_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../routes_name.dart';
import 'base_page.dart';

class FleetStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FleetStatusState();
}

class _FleetStatusState extends StatefulBasePage<FleetStatus> {
  _FleetStatusState() : super(true);

  int updateCount = 0;

  DateTime? lastBackendRead;

  String ageString = "???";

  Timer? timer;

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    developer.log("init Fleet Status", level: Constants.DEBUG_LEVEL);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        updateCount++;

        DateTime? lbr = lastBackendRead;
        if (lbr != null) {
          Duration diff = DateTime.now().difference(lbr);
          int ageInMin = (diff.inSeconds / 60).floor();

          if (ageInMin > 0) {
            ageString = "$ageInMin min ($updateCount)";
          } else {
            ageString = "< 1 min ($updateCount)";
          }


        } else {
          ageString = "???";
        }
      });

      print("$lastBackendRead - $ageString");
      developer.log("FleetStatus.updateCount: ${updateCount}",
          level: Constants.DEBUG_LEVEL);
    });
  }

  @override
  void dispose() {
    super.dispose();
    developer.log("dispose  Fleet Status", level: Constants.DEBUG_LEVEL);

    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    final aircraftCardsProvider = Provider.of<AircraftProvider>(context);
    List<AircraftType> aircraftCards = aircraftCardsProvider.aircraftCards;
    lastBackendRead = aircraftCardsProvider.lastBackendRead;

    // TODO: Should SliverGridDelegateWithMaxCrossAxisExtent used  instead?
    double width = MediaQuery.of(context).size.width;
    int widthCard = (150);
    int countRow = width ~/ widthCard;

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ageString,
              textAlign: TextAlign.right,
            ),
          ),
          Flexible(
            child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: countRow,
                childAspectRatio: 5 / 3,
                children: List.generate(aircraftCards.length, (index) {
                  final DateTime? departureDateTime =
                      aircraftCards[index].departureDateTime;
                  String departureDateTimeText = (departureDateTime != null)
                      ? DateFormat.jm().format(departureDateTime)
                      : "";

                  return InkWell(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              departureDateTimeText,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                            Text(aircraftCards[index].acType,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Text(aircraftCards[index].acReg,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print('tapped');
                      Navigator.of(context).pushReplacementNamed(RoutesName.AC_STATUS,
                          arguments: aircraftCards[index].acReg);
                    },
                  );
                })),
          ),
        ],
      )),
    );
  }

  @override
  String getTitle(BuildContext context) {
    return "Fleet Status";
  }
}
