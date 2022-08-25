import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as lg;
import 'package:logging/logging.dart';

class Logger {
  final _logger = lg.Logger("core");

  Logger() {
    lg.Logger.root.level = Level.INFO;

    lg.Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  logError(error) {
    if (defaultTargetPlatform != TargetPlatform.macOS) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(error);
    }

    _logger.shout(error);
  }
}

class LoggerMixin {
  final _logger = Logger();

  @protected
  Function(dynamic error) get logError => _logger.logError;
}
