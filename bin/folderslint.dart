import 'package:folderslint/folderslint.dart';

void main(List<String> arguments) {
  final filePaths = getFileList(inputFiles: arguments);

  if (filePaths.isNotEmpty) {
    runLinter(filePaths);
  }
}
