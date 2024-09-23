import 'dart:io';
import 'package:yaml/yaml.dart';

class AppInfo {
  dynamic _getPubspec() async {
    final file = File('${_projectRoot(file: 'pubspec.yaml')}/pubspec.yaml');
    final yamlString = await file.readAsString();
    return loadYaml(yamlString);
  }

  List<String> getGitScope()  {
    final file = File('${_projectRoot(file: '.gitscope')}/.gitscope');
    return file.readAsLinesSync();
  }

  String _projectRoot({required String file}) {
    Directory root = Directory.current;

    while (root.path.isNotEmpty && !File('${root.path}/$file').existsSync()) {
      root = root.parent;
    }

    return root.path;
  }

  Future<String> get version async {
    final pubspec = await _getPubspec();
    return pubspec['version'];
  }

  Future<String> get name async {
    final pubspec = await _getPubspec();
    return pubspec['name'];
  }
}