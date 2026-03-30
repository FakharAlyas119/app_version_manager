import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import '../interfaces/file_manager.dart';
import '../interfaces/version_interface.dart';
import '../models/version.dart';

/// Reads and writes the `version` field in a YAML file (typically `pubspec.yaml`).
///
/// Uses [YamlEditor] to preserve the existing file formatting.
///
/// ```dart
/// final manager = YamlFileManager();
/// final current = manager.getCurrentVersion();
/// print(current); // 1.0.0+1
/// manager.updateVersion(Version(1, 0, 1, 2));
/// ```
class YamlFileManager implements IFileManager {
  /// Creates a [YamlFileManager] targeting the given [filePath].
  ///
  /// Defaults to `'pubspec.yaml'` in the current working directory.
  YamlFileManager({this.filePath = 'pubspec.yaml'});

  /// The path to the YAML file being managed.
  final String filePath;

  @override
  Version getCurrentVersion() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final yaml = loadYaml(content);
    final currentVersion = yaml['version'] as String;
    return Version.parse(currentVersion);
  }

  @override
  void updateVersion(IVersion version) {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final editor = YamlEditor(content)..update(['version'], version.toString());
    file.writeAsStringSync(editor.toString());
  }
}
