import 'dart:io';
import 'parse_config.dart'; // Assuming that parseConfig.dart is in the same directory
import 'rules.dart'; // Assuming that rules.dart is in the same directory
import 'check_directories.dart'; // Assuming that checkDirectories.dart is in the same directory
import 'logger.dart'; // Assuming that loggers.dart is in the same directory

void logErrors(List<String> errorPaths) {
  for (var path in errorPaths) {
    logError(path);
  }
}

void runLinter(List<String> filePaths) {
  var config = parseConfig();
  String? root = config['root'];
  var rules = config['rules'];
  var extendedConfig = getExtendedRules(root ?? '', rules);
  var extendedRules = extendedConfig['rules'];
  var extendedRoot = extendedConfig['root'];

  var errorPaths = checkDirectories(filePaths, extendedRules, extendedRoot);

  if (errorPaths.isNotEmpty) {
    logErrors(errorPaths);
    logErrorsStats(errorPaths);
    exit(1);
  } else {
    logSuccess();
  }
}
