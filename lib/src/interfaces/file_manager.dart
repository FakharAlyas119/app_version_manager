import '../models/version.dart';

/// Interface for reading and writing version information to a file.
///
/// Implementations handle the file format (e.g., YAML for `pubspec.yaml`).
abstract class IFileManager {
  /// Reads the current version from the managed file.
  ///
  /// Throws if the file does not exist or the version field is missing.
  Version getCurrentVersion();

  /// Writes the given [version] to the managed file.
  void updateVersion(Version version);
}
