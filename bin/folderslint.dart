import 'package:chalkdart/chalk.dart';
import 'package:path/path.dart' as p;
import 'package:folderslint/folderslint.dart';

void main(List<String> arguments) {

  final filePaths = getFileList(inputFiles: arguments);

  if (filePaths.isNotEmpty) {
    print('running ${chalk.doubleUnderline(chalk.magenta(chalk.font7('folderslint')))} in ${chalk.cyan(p.current)}');
    runLinter(filePaths);
  }
}
