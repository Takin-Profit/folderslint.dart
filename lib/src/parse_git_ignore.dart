import 'dart:io';

import 'package:path/path.dart' as p;

const String gitIgnore = '.gitignore';

List<String> getIgnoredDirs() {
  try {
    final config = File(p.absolute('.gitignore')).readAsStringSync();
    return config
        .split(lineSeparator())
        .map((line) => p.absolute(line))
        .where((line) => !line.startsWith('#') && line.isNotEmpty)
        .toList();

  } catch (err) {
    stderr.writeln(err);
    exit(1);
  }
}

String lineSeparator() => Platform.isWindows ? '\r\n' : '\n';
