import 'package:logger/logger.dart';

class CustomLogPrinter extends LogPrinter {
  final String className;
  CustomLogPrinter({required this.className});

  final logger = Logger();

  @override
  List<String> log(LogEvent event) {
    var emoji = PrettyPrinter.levelEmojis[event.level];
    return ['$emoji $className - ${event.message}'];
  }
}
