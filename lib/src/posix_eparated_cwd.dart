import 'dart:io';

String posixSeparatedCwd() {
  return Directory.current.path.replaceAll(Platform.pathSeparator, '/');
}
