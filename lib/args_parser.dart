import 'package:args/args.dart';
import 'package:git_conventional_commit/core.dart';

class Arguments {
  final bool isVerbose;
  final bool showHelp;
  final bool showVersion;
  final String commitType;
  final String commitDescription;

  const Arguments({
    required this.showVersion,
    required this.showHelp,
    required this.isVerbose,
    required this.commitType,
    required this.commitDescription,
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
        'description',
        abbr: 'd',
        mandatory: true,
        help: 'Commit description.',
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

  static _getOptionOrThrowException(ArgResults results, {required String option, String? errorMessage}) {
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
      commitType: _getOptionOrThrowException(results, option: 'type'),
      commitDescription: _getOptionOrThrowException(results, option: 'description'),
    );
  }
}
