import 'package:scflutter/utils/logger.dart';

class SociumCore {
  final _logger = Logger();

  Function(dynamic error) get logError => _logger.logError;
}
