import 'package:logging/logging.dart' as lg;

class Logger {
  final _logger = lg.Logger("core");
  Logger();

  error(Object error) {
    _logger.shout(error);
  }
}
