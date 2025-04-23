import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import '../interfaces/file_manager.dart';
import '../interfaces/version_interface.dart';
import '../models/version.dart';

class YamlFileManager implements IFileManager {
  YamlFileManager({this.filePath = 'pubspec.yaml'});
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
