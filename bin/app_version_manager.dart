import 'dart:io';

import 'package:app_version_manager/src/utils/logger.dart';
import 'package:app_version_manager/app_version_manager.dart';

void main(List<String> args) {
  final logger = Logger();

  try {
    if (args.isEmpty) {
      logger.error(
        'Please provide a command: major, minor, patch, build, or bump',
      );
      exit(1);
    }

    final command = args.join(' ');

    // Initialize the YAML file manager to read and write version information
    final yamlFileManager = YamlFileManager();
    final currentVersion = yamlFileManager.getCurrentVersion();
    logger.info('Current version: $currentVersion');

    final IVersionModifier modifier = IVersionModifier(command);

    // Create and execute the appropriate version command based on user input
    final versionCommand = VersionCommandFactory.create(command, modifier);
    final newVersion = versionCommand.execute(currentVersion);

    logger.info('Updated version $newVersion');
    yamlFileManager.updateVersion(newVersion);

    logger.success('Successfully updated version to $newVersion');
  } catch (e, stackTrace) {
    logger
      ..error('Error: $e')
      ..error('Stack trace: $stackTrace');
    exit(1);
  }
}
