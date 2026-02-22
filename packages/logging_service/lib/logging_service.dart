import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'dart:developer' as dev;
export 'package:logging_service/extensions/logger_extensions.dart';
export 'package:logging_service/extensions/string_extensions.dart';

class LoggingService {
  // ANSI escape codes for colored output
  static const _end = '\x1b[0m';
  static const _white = '\x1b[37m';
  static const _cyan = '\x1b[36m';
  static const _yellow = '\x1b[33m';
  static const _red = '\x1b[31m';

  static void init() {
    Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;

    Logger.root.onRecord.listen((record) {
      if (kDebugMode || record.level >= Level.WARNING) {
        final color = _getColorForLevel(record.level);

        dev.log(
          '$color${record.message}$_end',
          name: record.loggerName,
          level: record.level.value,
          time: record.time,
          zone: record.zone,
          error: record.error,
          stackTrace: record.stackTrace,
        );

        // TODO: Add crashlitics
      }
    });
  }

  static String _getColorForLevel(Level level) {
    switch (level) {
      case Level.SEVERE:
        return _red;
      case Level.WARNING:
        return _yellow;
      case Level.INFO:
        return _cyan;
      case Level.FINE:
      case Level.FINER:
      case Level.FINEST:
        return _white;
      default:
        return _white;
    }
  }

  static Logger getLogger(String name) => Logger(name);
}
