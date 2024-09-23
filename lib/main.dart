import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:git_conventional_commit/app_info.dart';
import 'package:git_conventional_commit/commit_type.dart';
import 'package:git_conventional_commit/git_command_builder.dart';

import 'args_parser.dart';

/*

Example of usage:
dart lib/main.dart -t feat -m "Add new feature" -b -s '#1234'

gc -m 'Add something'

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
      print("Message: ${args.commitMessage}");
      print("Scope: ${args.commitScope}");
      print("Breaking: ${args.isBreakingChange}");

      final String gitCommand;

      if (args.amend) {
        gitCommand = 'git commit --amend';
      } else {
        gitCommand = GitCommandBuilder().buildCommit(
          type: args.commitType,
          message: args.commitMessage,
          scope: args.commitScope,
          isBreaking: args.isBreakingChange,
        );
      }

      print(gitCommand);
    }
  }, onError: (error) {
    try {
      print(error.message);
      showHelp();
    } catch (e) {
      print("$error\n");
      stdout.write(error.stackTrace);
    }
  });
}

showHelp() {
  print("\nUsage:");
  print(Arguments.usage);
}
