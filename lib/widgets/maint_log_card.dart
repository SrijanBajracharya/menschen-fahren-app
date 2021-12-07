
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_menschen_fahren/helper.dart';
import 'package:project_menschen_fahren/models/maint_log_type.dart';
import 'package:project_menschen_fahren/routes_name.dart';

class MaintLogCard extends StatelessWidget {
  final MaintLogType maintLog;
  final bool detailMode;

  MaintLogCard({Key? key, required this.maintLog, this.detailMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:  Card(
        color: Helper.getColorFromWarningLevel(maintLog.warningLevel),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 6,
            height: 1,
          ),
          Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Column on the Left

                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(maintLog.recordName,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45)),
                            SizedBox(width: 8),
                            Text(maintLog.recordName,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black45)),
                            const SizedBox(width: 8),
                            const Text("MEL C",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(maintLog.description,
                            overflow: TextOverflow.ellipsis,
                            // TODO: why does null not work???
                            maxLines: detailMode ? 100000 : 6,
                            //"DURING SERVICE CHECK FOUND DAMAGED BACKSHELL-CONNECTOR OF NLG DOOR OPEN PROXIMITY SENSOR",
                            style:
                                const TextStyle(fontSize: 12, color: Colors.black87)
                        ),
                      ],
                    ),
                  )),
                  // Column on the Right
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _createRightSide()),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      onTap: () {
        if (detailMode) {
          // we are already at detail level, no need to sho details page
        } else {
          Navigator.of(context)
              .pushReplacementNamed(RoutesName.ITEM_DETAILS, arguments: maintLog);
        }
      },
    );
  }

  List<Widget> _createRightSide() {
    List<Widget> list = [];

    list.add(_createRightSideEntry(
        FontAwesomeIcons.file, Helper.formatDate(maintLog.entryDateTime)));

    DateTime? expirationDate = maintLog.expirationDate;
    if (expirationDate != null) {

      list.add(SizedBox(height: 6));

      list.add(_createRightSideEntry(FontAwesomeIcons.calendarAlt,
          Helper.formatDate(expirationDate)));
    }

    int? fh = maintLog.expirationFlightHours;
    if (fh != null) {
      list.add(SizedBox(height: 6));

      list.add(_createRightSideEntry(FontAwesomeIcons.calendarAlt,
           "$fh FH"));
    }

    int? fc = maintLog.expirationFlightCycles;
    if (fc != null) {
      list.add(SizedBox(height: 6));

      list.add(_createRightSideEntry(FontAwesomeIcons.calendarAlt,
           "$fc FC "));
    }

    list.add(SizedBox(height: 6));

    String? ataNum = maintLog.ataNum;
    if (ataNum != null)
    list.add(
        _createRightSideEntry(FontAwesomeIcons.crosshairs, ataNum));
    return list;
  }

// Creates RichtText for Line on right side
  RichText _createRightSideEntry(IconData iconData, String text) {
    return  RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.black87),
        children: [
          WidgetSpan(child: FaIcon(iconData, size: 14)),
          const TextSpan(text: " "),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
