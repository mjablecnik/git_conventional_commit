import 'dart:io';

class AppInfo {
  List<String> get gitScope {
    var rootPath = _projectRoot(file: '.gitscope');
    if (rootPath == null) return [];

    final file = File('$rootPath/.gitscope');
    return file.readAsLinesSync();
  }

  String? _projectRoot({required String file}) {
    Directory root = Directory.current;

    while (root.path.isNotEmpty && !File('${root.path}/$file').existsSync()) {
      if (root.path == '/') return null;
      root = root.parent;
    }

    return root.path;
  }

  String get version => "1.0.0";

  String get name => "git_conventional_commit";
}
