import 'dart:io';

import 'package:git_conventional_commit/app_info.dart';
import 'package:git_conventional_commit/git_command_builder.dart';

import 'args_parser.dart';

void main(List<String> args) {
  Arguments.parse(args).then((args) async {
    if (args.showHelp) {
      showHelp();
    } else if (args.showVersion) {
      print("Version: ${AppInfo().version}");
    } else {
      final List<String> gitArgs;

      if (args.amend) {
        gitArgs = ['commit', '--amend'];
      } else {
        final commitMessage = GitCommandBuilder().buildCommitMessage(
          type: args.commitType,
          message: args.commitMessage,
          scope: args.commitScope,
          isBreaking: args.isBreakingChange,
        );
        gitArgs = ['commit', '-m', commitMessage];
      }

      print('');

      final p = await Process.start('git', gitArgs);
      await stdout.addStream(p.stdout);

      exit(0);
    }
  }, onError: (error) {
    try {
      print(error.message);
      showHelp();
    } catch (e) {
      print("$error\n");
      stdout.write(error.stackTrace);
    } finally {
      exit(1);
    }
  });
}

showHelp() {
  print("\nUsage:");
  print(Arguments.usage);
}
