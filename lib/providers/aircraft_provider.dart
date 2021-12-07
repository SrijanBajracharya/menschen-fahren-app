import 'dart:collection';
import 'dart:convert';

import 'package:project_menschen_fahren/models/aircraft_type.dart';
import 'package:flutter/material.dart';


class AircraftProvider extends ChangeNotifier {

  List<AircraftType> aircraftCards = [];

  DateTime? lastBackendRead;

  AircraftProvider() {
    final json = """
 [
   {
      "acReg":"D-CROC",
      "acType":"A320",
      "departureDateTime":"2021-05-23T18:25:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": true,
      "melCatD": false
   },
   {
      "acReg":"D-CROD",
      "acType":"A380",
      "departureDateTime":"2021-05-23T18:27:00Z",
      "warnLevel": 2,
      "aog": true,
      "melDueLevel": 3,
      "ops": false,
      "melCatA": true,
      "melCatB": true,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROE",
      "acType":"B777",
      "departureDateTime":"2021-05-23T18:29:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 2,
      "ops": false,
      "melCatA": true,
      "melCatB": true,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROF",
      "acType":"A380",
      "departureDateTime":"2021-05-23T18:34:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": true,
      "melCatA": false,
      "melCatB": false,
      "melCatC": true,
      "melCatD": false
   },
      {
      "acReg":"D-CROG",
      "acType":"B737",
      "departureDateTime":"2021-05-23T18:45:00Z",
      "warnLevel": 2,
      "aog": false,
      "melDueLevel": 2,
      "ops": true,
      "melCatA": true,
      "melCatB": false,
      "melCatC": false,
      "melCatD": true
   },
      {
      "acReg":"D-CROH",
      "acType":"A380",
      "departureDateTime":"2021-05-23T18:55:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROI",
      "acType":"A220",
      "departureDateTime":"2021-05-23T19:02:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROJ",
      "acType":"A320",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROK",
      "acType":"A320",
      "departureDateTime":"2021-05-23T19:47:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROL",
      "acType":"A380",
      "departureDateTime":"2021-05-23T20:12:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROM",
      "acType":"A380",
      "departureDateTime":"2021-05-23T20:25:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CRON",
      "acType":"A322",
      "departureDateTime":"2021-05-23T22:55:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROO",
      "acType":"A380",
      "departureDateTime":"2021-05-23T23:15:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROP",
      "acType":"A322",
      "departureDateTime":"2021-05-24T00:11:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"D-CROQ",
      "acType":"A380",
      "departureDateTime":"2021-05-24T00:25:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
         {
      "acReg":"HB-JNA",
      "acType":"A220",
      "departureDateTime":"2021-05-23T18:37:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"HB-JNB",
      "acType":"B777",
      "departureDateTime":"2021-05-24T01:32:00Z",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"HB-JNAF",
      "acType":"B777",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"HB-IJR",
      "acType":"A320",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
    {
      "acReg":"HB-LPI",
      "acType":"B737",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
    },
      {
      "acReg":"HB-IJK",
      "acType":"B737",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   },
      {
      "acReg":"HB-CDQ",
      "acType":"A322",
      "warnLevel": 0,
      "aog": false,
      "melDueLevel": 1,
      "ops": false,
      "melCatA": false,
      "melCatB": false,
      "melCatC": false,
      "melCatD": false
   }    
]
    """;
    final dynamic parsedList = jsonDecode(json).cast<Map<String, dynamic>>();
    aircraftCards = List<AircraftType>.from(
        parsedList.map((i) => AircraftType.fromJson(i)));

    lastBackendRead = DateTime.now();
  }

  UnmodifiableListView<AircraftType> get allAircraftCard =>
      UnmodifiableListView(aircraftCards);

  set allAircraftCard(List<AircraftType> newAircraftCards) {

    aircraftCards = newAircraftCards;

    // TODO: as soon as real data is used, this is a timestamp from server db.
    lastBackendRead = DateTime.now();

    notifyListeners();
  }
}
