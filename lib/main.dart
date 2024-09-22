import 'package:git_conventional_commit/app_info.dart';

import 'args_parser.dart';

/*

Example of usage:
dart lib/main.dart -V --name Martin -t dart,python,java

 */
void main(List<String> args) {
  Arguments.parse(args).then((args) async {
    if (args.showHelp) {
      showHelp();
    } else if (args.showVersion) {
      print("Version: ${await AppInfo().version}");
    } else {
      print("Verbose: ${args.isVerbose}");
      print("Type: ${args.commitType}");
      print("Description: ${args.commitDescription}");
    }
  }, onError: (error) {
    print(error.message);
    showHelp();
    return;
  });
}

showHelp() {
  print("\nUsage:");
  print(Arguments.usage);
}
