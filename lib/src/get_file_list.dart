import 'dart:io';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

bool isDirSync(String pathName) =>
    FileSystemEntity.isDirectorySync(pathName);

List<String> getFileList(
    {List<String>? inputFiles, String include = '**/*', String? cwd}) {

  cwd ??= Directory.current.path;
  inputFiles ??= [];
  
  if (inputFiles.isEmpty) {
    return Glob(include).listSync(followLinks: false, root: cwd)
        .map((file) => file.path)
        .toList();
  }

  if (inputFiles.length == 1 && isDirSync(inputFiles[0])) {
    return getFileList(inputFiles: [], include: include, cwd: inputFiles[0]);
  }
  
  return inputFiles;
}
