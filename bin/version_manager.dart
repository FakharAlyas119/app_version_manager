import 'dart:io';

/// Version Manager CLI
///
/// A command-line tool for managing version numbers in Flutter applications.
/// This tool follows semantic versioning principles and handles both
/// App Store and Play Store versioning conventions.
///
/// Usage:
///   dart bin/app_version_manager.dart <command>
///
/// Commands:
///   major - Increments the major version (X.0.0+build)
///   minor - Increments the minor version (x.X.0+build)
///   patch - Increments the patch version (x.x.X+build)
///   build - Increments only the build number (x.x.x+X)
///   bump  - Alias for patch increment
void main(List<String> args) {
  final logger = _Logger();

  try {
    if (args.isEmpty) {
      logger.error(
        'Please provide a command: major, minor, patch, build, or bump',
      );
      exit(1);
    }

    final command = args[0];

    // Initialize the YAML file manager to read and write version information
    final yamlFileManager = YamlFileManager();
    final currentVersion = yamlFileManager.getCurrentVersion();
    logger.info('Current version: $currentVersion');

    final versionIncrementor = VersionIncrementor();
    late IVersion newVersion;

    // Create and execute the appropriate version command based on user input
    final versionCommandFactory = VersionCommandFactory.create(
      command,
      versionIncrementor,
    );
    newVersion = versionCommandFactory.execute(currentVersion);

    logger.info('Updated version $newVersion');
    yamlFileManager.updateVersion(newVersion);

    logger.success('Successfully updated version to $newVersion');
  } on Exception catch (e) {
    logger.error(e.toString());
  } catch (e, stackTrace) {
    logger
      ..error('Error: $e')
      ..error('Stack trace: $stackTrace');
    exit(1);
  }
}

/// A utility class for colorful console logging
///
/// Provides methods for displaying different types of messages
/// with appropriate colors for better readability in the terminal.
class _Logger {
  // ANSI color codes for terminal output
  static const _reset = '\x1B[0m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _red = '\x1B[31m';
  static const _cyan = '\x1B[36m';
  static const _lightGreen = '\x1B[92m';

  /// Logs a debug message in cyan
  void debug(String message) {
    print('${_cyan}DEBUG: $message$_reset');
  }

  /// Logs an informational message in green
  void info(String message) {
    print('${_green}INFO: $message$_reset');
  }

  /// Logs a warning message in yellow
  void warning(String message) {
    print('${_yellow}WARNING: $message$_reset');
  }

  /// Logs an error message in red
  void error(String message) {
    print('${_red}ERROR: $message$_reset');
  }

  /// Logs a success message in light green
  void success(String message) {
    print('${_lightGreen}SUCCESS: $message$_reset');
  }
}
