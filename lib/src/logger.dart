import 'package:chalkdart/chalk.dart';

const String ERROR_MESSAGE = 'Directory is not allowed by config';
const String SUCCESS_MESSAGE = '✅ All checked directories are allowed by config';

void logError(String path) {
  print('${chalk.red('error ❌')} :  ${chalk.red(chalk.underline(path))}');
  print(chalk.bgBrightRed(ERROR_MESSAGE));
}

void logErrorsStats(List<String> errorPaths) {
  print('');
  print('folderslint: ${errorPaths.length} error(s) found');
}

void logSuccess() {
  print(SUCCESS_MESSAGE);
}
