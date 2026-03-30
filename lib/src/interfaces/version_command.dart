import '../models/version.dart';

/// Interface for a version modification command.
///
/// Each command encapsulates a specific version operation (e.g., increment
/// major, revert patch) and delegates to an [IVersionModifier] strategy.
abstract class IVersionCommand {
  /// Executes the command on [currentVersion] and returns the new version.
  Version execute(Version currentVersion);

  /// The name of this command (e.g., `'major'`, `'patch'`, `'bump'`).
  String get commandName;
}
