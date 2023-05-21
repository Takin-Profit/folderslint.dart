import 'dart:io';
import 'rules.dart'; // Assuming that the rules.dart file is in the same directory

List<String> checkDirectories(List<String> filePaths, List<String> rules, String root) {
  var errorPaths = <String>[];

  for (var path in filePaths) {
    // Skip files which are not in the root directory
    if (!path.startsWith(root)) {
      continue;
    }

    var isDirectory = FileSystemEntity.isDirectorySync(path);
    String pathToCheck;

    if (isDirectory) {
      pathToCheck = path;
    } else {
      var splittedPath = path.split('/');
      splittedPath.removeLast();
      var directoryPath = splittedPath.join('/');
      pathToCheck = directoryPath;
    }

    if (!checkPath(pathToCheck, rules) && !errorPaths.contains(pathToCheck)) {
      errorPaths.add(pathToCheck);
    }
  }

  return errorPaths;
}
