import 'package:flutter_mvvm_template/core/others/logger_customizations/custom_log_output.dart';
import 'package:flutter_mvvm_template/core/others/logger_customizations/custom_log_printer.dart';
import 'package:logger/logger.dart';

class CustomLogger extends Logger {
  final String className;

  CustomLogger({required this.className})
      : super(
          output: CustomLogOutput(),
          printer: CustomLogPrinter(className: className),
        );
}
