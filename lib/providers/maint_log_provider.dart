/*
import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:project_menschen_fahren/models/ac_status_category_type.dart';
import 'package:project_menschen_fahren/models/maint_log_type.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MaintLogProvider extends ChangeNotifier {
  List<MaintLogType> openMaintLogs = [];
  List<MaintLogType> deferredMaintLogs = [];
  List<MaintLogType> briefingCardMaintLogs = [];

  List<AcStatusCategoryType> categories = [];

  MaintLogProvider() {
    final jsonOpen = """
 [
   {
      "id":"g1j3-a4z56-t78c9-d34a",
      "recordName":"WO123456",
      "entryDateTime":"2021-05-23T00:00:00Z",
      "description":"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ",
      "ataNum":"22-33",
      "typeOfMaintLog":"FAULT",
      "status":"PEND",
      "warningLevel":2           
   },
   {
      "id":"g1j3-a4z56-t78c9-d34a",
      "recordName":"WO4711",
      "entryDateTime":"2021-05-23T00:00:00Z",
      "description":"LALALALALALAL",
      "ataNum":"22-33",
      "typeOfMaintLog":"FAULT",
      "status":"PEND",
      "warningLevel":2           
   }
 ]
   """;

    final jsonDeferred = """
 [
   {
      "id":"g1j3-a4z56-t78c9-d34a",
      "recordName":"WO0815",
      "entryDateTime":"2021-05-23T00:00:00Z",
      "description":"DURING SERVICE CHECK FOUND DAMAGED BACKSHELL-CONNECTOR OF NLG DOOR OPEN PROXIMITY SENSOR",
      "ataNum":"22-33",
      "typeOfMaintLog":"FAULT",
      "status":"DFRL",
      "deferralAuthorityRef":"74-31-01A",
      "typeOfDeferral":"M",
      "melCategory":"B",
      "expirationDate":"2021-05-24T00:00:00Z",
      "expirationFlightCycles":34,
      "expirationFlightHours":50,
      "warningLevel":1           
   },
   {
      "id":"g1j3-a4z56-t78c9-d34a",
      "recordName":"WO654321",
      "entryDateTime":"2021-05-23T00:00:00Z",
      "description":"DURING SERVICE CHECK FOUND DAMAGED BACKSHELL-CONNECTOR OF NLG DOOR OPEN PROXIMITY SENSOR",
      "ataNum":"22-33",
      "typeOfMaintLog":"FAULT",
      "status":"DFRL",
      "deferralAuthorityRef":"74-31-01A",
      "typeOfDeferral":"M",
      "melCategory":"B",
      "expirationDate":"2021-05-24T00:00:00Z",
      "expirationFlightCycles":34,
      "expirationFlightHours":50,
      "warningLevel":0           
   }
 ]
   """;

    final jsonBriefing = """
 [
   {
      "id":"bjj3-6zz56-ko8c9-d14a",
      "recordName":"WO01001010101",
      "entryDateTime":"2021-05-23T00:00:00Z",
      "description":"DURING SERVICE CHECK FOUND DAMAGED BACKSHELL-CONNECTOR OF NLG DOOR OPEN PROXIMITY SENSOR",
      "ataNum":"22-33",
      "typeOfMaintLog":"FAULT",
      "status":"DFRL",
      "deferralAuthorityRef":"74-31-01A",
      "typeOfDeferral":"M",
      "melCategory":"B",
      "expirationDate":"2021-05-24T00:00:00Z",
      "expirationFlightCycles":34,
      "expirationFlightHours":50,
      "warningLevel":0           
   },
   {
      "id":"go33-hj1z56-b1d8c9-hu24a",
      "recordName":"WO112233",
      "entryDateTime":"2021-05-23T00:00:00Z",
      "description":"DURING SERVICE CHECK FOUND DAMAGED BACKSHELL-CONNECTOR OF NLG DOOR OPEN PROXIMITY SENSOR",
      "ataNum":"22-33",
      "typeOfMaintLog":"FAULT",
      "status":"DFRL",
      "deferralAuthorityRef":"74-31-01A",
      "typeOfDeferral":"M",
      "melCategory":"B",
      "expirationDate":"2021-05-24T00:00:00Z",
      "expirationFlightCycles":34,
      "expirationFlightHours":50,
      "warningLevel":0           
   }
 ]
   """;

    developer.log("Just for DEMO: read in some Dummy Data",
        level: Constants.DEBUG_LEVEL);

    developer.log("Reading in Open Items", level: Constants.TRACE_LEVEL);
    final dynamic parsedListOpen = jsonDecode(jsonOpen).cast<Map<String, dynamic>>();
    for (var i = 0; i < parsedListOpen.length; i++) {
      print(parsedListOpen[i]);
      openMaintLogs.add(MaintLogType.fromJson(parsedListOpen[i]));
    }

    developer.log("Reading in Deferred Items", level: Constants.TRACE_LEVEL);
    final parsedListDeferred =
        jsonDecode(jsonDeferred).cast<Map<String, dynamic>>();
    for (var i = 0; i < parsedListDeferred.length; i++) {
      print(parsedListDeferred[i]);
      deferredMaintLogs.add(MaintLogType.fromJson(parsedListDeferred[i]));
    }
//    deferredMaintLogs = List<MaintLogType>.from(
//        parsedListDeferred.map((j) => MaintLogType.fromJson(j)));

    developer.log("Reading in Biefing Items", level: Constants.TRACE_LEVEL);
    final briefingListOpen = jsonDecode(jsonBriefing).cast<Map<String, dynamic>>();
    for (var i = 0; i < briefingListOpen.length; i++) {
      print(briefingListOpen[i]);
      briefingCardMaintLogs.add(MaintLogType.fromJson(briefingListOpen[i]));
    }

    categories = [
      new AcStatusCategoryType("Open", openMaintLogs),
      new AcStatusCategoryType("Deferred", deferredMaintLogs),
      new AcStatusCategoryType("BriefingCards", briefingCardMaintLogs),
    ];
  }

  UnmodifiableListView<AcStatusCategoryType> get acStatusCategories =>
      UnmodifiableListView(categories);

  set acStatusCategories(List<AcStatusCategoryType> newCategories) {
    developer.log("AC Status categories set, Listeners notified. ",
        level: Constants.DEBUG_LEVEL);
    categories = newCategories;
    notifyListeners();
  }
}
*/
