import 'package:args/args.dart';
import 'package:git_conventional_commit/core.dart';

enum CommandType { option, multipleOption, flag }

enum Commands {
  type(abbr: 't', isMandatory: false, commandType: CommandType.option, commandHelp: 'Commit type.'),
  message(abbr: 'm', isMandatory: false, commandType: CommandType.option, commandHelp: 'Commit message.'),
  scope(abbr: 's', commandType: CommandType.option, commandHelp: 'Commit scope.'),
  breaking(abbr: 'b', commandType: CommandType.flag, commandHelp: 'Set commit as breaking change.'),
  help(abbr: 'h', commandType: CommandType.flag, commandHelp: 'Print this usage information.'),
  verbose(abbr: 'V', commandType: CommandType.flag, commandHelp: 'Show additional command output.'),
  version(abbr: 'v', commandType: CommandType.flag, commandHelp: 'Print the tool version.'),
  ;

  const Commands({
    this.abbr,
    this.isMandatory = false,
    required this.commandHelp,
    required this.commandType,
  });

  final String? abbr;
  final bool isMandatory;
  final String commandHelp;
  final CommandType commandType;
}

class Arguments {
  final bool isVerbose;
  final bool showHelp;
  final bool showVersion;
  final String? commitType;
  final String? commitMessage;
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
    final argParser = ArgParser();
    for (var value in Commands.values) {
      switch (value.commandType) {
        case CommandType.option:
          argParser.addOption(value.name, abbr: value.abbr, mandatory: value.isMandatory, help: value.commandHelp);
        case CommandType.multipleOption:
          argParser.addMultiOption(value.name, abbr: value.abbr, help: value.commandHelp);
        case CommandType.flag:
          argParser.addFlag(value.name, abbr: value.abbr, help: value.commandHelp);
      }
    }
    return argParser;
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
      showHelp: results.wasParsed(Commands.help.name),
      isVerbose: results.wasParsed(Commands.verbose.name),
      showVersion: results.wasParsed(Commands.version.name),
      commitType: _getOptionOrNull(results, option: Commands.type.name),
      commitMessage: _getOptionOrNull(results, option: Commands.message.name),
      commitScope: _getOptionOrNull(results, option: Commands.scope.name),
      isBreakingChange: results.wasParsed(Commands.breaking.name),
    );
  }
}
