import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {

  static final DateFormat _dateFormatter = DateFormat('yyyy MMM dd');

  static Color getColorFromWarningLevel(int warningLevel) {
    switch (warningLevel) {
      case 0:
      // 0 Means no Warning
        return Colors.black12;
        break;

      case 1:
        return Colors.amber;
        break;

      case 2:
        return Colors.red;
        break;

      default:
      // Unknown Warning Level
        return Colors.purple;
    }
  }

  // Formats a DateTime as Date
  static String formatDate(DateTime dateTime) {
    if (dateTime == null) {
      return " ";
    } else {
      return _dateFormatter.format(dateTime);
    }
    ;
  }
}
