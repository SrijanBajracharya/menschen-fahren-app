import 'package:logger/logger.dart';

class ClassLogPrinter extends LogPrinter {

  final String className;

  ClassLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var level = _levelCode(event.level);
    var message = event.message;
    var color = PrettyPrinter.levelColors[event.level];
    var date = DateTime.now();
    // TODO print stacktrace?
    return [color!('$date: [$level] [$className]: $message')];
  }

  /* Return a shortened code based on the log level. */
  String _levelCode(Level level) {

    switch(level) {
      case Level.verbose:
        return "V";
      case Level.debug:
        return "D";
      case Level.info:
        return "I";
      case Level.warning:
        return "W";
      case Level.error:
        return "E";
      case Level.wtf:
        return "WTF";
      case Level.nothing:
        return "-";
    }
  }
}

/* Returns a logger for the provided class. */
Logger getLogger(String className) {
  return Logger(
    printer: ClassLogPrinter(className),
  );
}