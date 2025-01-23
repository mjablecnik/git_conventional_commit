import 'dart:io';

class AppInfo {
  List<String> get gitScope {
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

  String get version => "1.0.0";

  String get name  => "git_conventional_commit";
}