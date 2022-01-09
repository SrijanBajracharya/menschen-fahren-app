/*
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/models/ac_status_category_type.dart';
import 'package:project_menschen_fahren/models/maint_log_type.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:project_menschen_fahren/providers/maint_log_provider.dart';
import 'package:project_menschen_fahren/widgets/maint_log_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as developer;

import 'package:provider/provider.dart';

class AcStatus extends StatefulWidget {

  final String acReg;

  AcStatus({Key? key, required this.acReg}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AcStatusState();

}

class _AcStatusState extends StatefulBasePage<AcStatus> {
  _AcStatusState() : super(true);
  int dummyTestStateRemoveLater = 0;

  @override
  void initState() {

     // todo fetch data from service

    developer.log("_AcStatusState initState... ", level:Constants.TRACE_LEVEL);

    setState(() {
      dummyTestStateRemoveLater = 42;
    });

    //developer.log('init AcStatus', level:Constants.DEBUG_LEVEL);
  }

  @override
  void dispose() {
    super.dispose();
    // todo
    //developer.log('dispose AcStatus', level:Constants.DEBUG_LEVEL);
  }

  @override
  Widget buildContent(BuildContext context) {

    developer.log("Building _AcStatusState... ", level:Constants.TRACE_LEVEL);

    final maintLogProvider = Provider.of<MaintLogProvider>(context);
    List<AcStatusCategoryType> categories = maintLogProvider.acStatusCategories;

    developer.log("Building _AcStatusState: Construct List for ListView . ", level:Constants.TRACE_LEVEL);
    List<Widget> listItems = [];
    for (var i=0; i<categories.length; i++) {
      // Add Category Header
      listItems.add(Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
        child: Text(categories[i].categoryName,
            style: TextStyle(fontSize: 14, color: Colors.black45)),
      ));

      List<MaintLogType> maintLogs = categories[i].maintLogs;
      if (maintLogs != null) {
        for (var j = 0; j < maintLogs.length; j++) {
          String recordName = maintLogs[j].recordName;
          DateTime entryDateTime = maintLogs[j].entryDateTime;
          DateTime? expirationDate = maintLogs[j].expirationDate;

          developer.log("Adding ListItem[$i,$j]: $recordName $entryDateTime $expirationDate", level:Constants.TRACE_LEVEL);
          listItems.add(MaintLogCard(maintLog: maintLogs[j], detailMode: false));
        }
      }
    }

    developer.log("Building _AcStatusState: Construct Scaffold. ", level:Constants.TRACE_LEVEL);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ListView(
              children: listItems,
                // listItems,
            )),
      ),
    );
  }

  @override
  String getTitle(BuildContext context) {
    return widget.acReg;
  }

}
*/
