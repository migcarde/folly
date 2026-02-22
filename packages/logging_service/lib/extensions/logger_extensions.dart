import 'package:logging/logging.dart';

extension LoggerExtensions on Logger {
  void logInfo({required String title, required String message}) {
    info(title);
    fine(message);
  }
}
