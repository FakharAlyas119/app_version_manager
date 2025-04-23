/// A SOLID-compliant version management tool for Flutter applications
/// that handles both App Store and Play Store versioning conventions.
library app_version_manager;

export 'src/commands/version_commands.dart';
export 'src/interfaces/file_manager.dart';
export 'src/interfaces/version_command.dart';
export 'src/interfaces/version_incrementer.dart';
export 'src/interfaces/version_interface.dart';
export 'src/models/version.dart';
export 'src/services/version_incrementer.dart';
export 'src/services/yaml_file_manager.dart';
