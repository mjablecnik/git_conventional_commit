import 'package:args/args.dart';
import 'package:git_conventional_commit/core.dart';

class Arguments {
  final bool isVerbose;
  final bool showHelp;
  final bool showVersion;
  final String commitType;
  final String commitMessage;
  final String? commitScope;
  final bool isBreakingChange;

  const Arguments({
    required this.showVersion,
    required this.showHelp,
    required this.isVerbose,
    required this.commitType,
    required this.commitMessage,
    required this.commitScope,
    required this.isBreakingChange,
  });

  static ArgParser _parser() {
    return ArgParser()
      ..addOption(
        'type',
        abbr: 't',
        mandatory: true,
        help: 'Commit type.',
      )
      ..addOption(
        'message',
        abbr: 'm',
        mandatory: true,
        help: 'Commit message.',
      )
      ..addOption(
        'scope',
        abbr: 's',
        help: 'Commit description.',
      )
      ..addFlag(
        'breaking',
        abbr: 'b',
        negatable: false,
        help: 'Set commit as breaking change.',
      )
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Print this usage information.',
      )
      ..addFlag(
        'verbose',
        abbr: 'V',
        negatable: false,
        help: 'Show additional command output.',
      )
      ..addFlag(
        'version',
        abbr: 'v',
        negatable: false,
        help: 'Print the tool version.',
      );
  }

  static get usage => _parser().usage;

  static _getOptionOrNull(ArgResults results, {required String option}) {
    return results.wasParsed(option) ? results.option(option) : null;
  }

  static _getOptionOrThrow(ArgResults results, {required String option, String? errorMessage}) {
    if (results.wasParsed(option)) {
      return results.option(option);
    } else {
      throw MissingOptionException(message: errorMessage ?? 'Missing option: \'$option\'');
    }
  }

  static Future<Arguments> parse(List<String> arguments) async {
    final ArgResults results = _parser().parse(arguments);
    return Arguments(
      showHelp: results.wasParsed('help'),
      isVerbose: results.wasParsed('verbose'),
      showVersion: results.wasParsed('version'),
      commitType: _getOptionOrThrow(results, option: 'type'),
      commitMessage: _getOptionOrThrow(results, option: 'message'),
      commitScope: _getOptionOrNull(results, option: 'scope'),
      isBreakingChange: results.wasParsed('breaking'),
    );
  }
}
