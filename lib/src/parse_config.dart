import 'dart:convert';
import 'dart:io';

const String configPath = '.folderslintrc';

Map<String, dynamic> parseConfig() {
  try {
    final config = File(configPath).readAsStringSync();
    return validateParsedConfig(jsonDecode(config));
  } catch (err) {
    stderr.writeln(err);
    exit(1);
  }
}

Map<String, dynamic> validateParsedConfig(Map<String, dynamic> config) {
  for (var rule in config['rules']) {
    if (rule.contains('**') && !rule.endsWith('**')) {
      stderr.writeln('Invalid rule: $rule');
      stderr.writeln('A rule can have ** only at the end');
      exit(1);
    }
  }
  return config;
}
