import '../interfaces/version_interface.dart';

/// Represents a semantic version with a build number.
///
/// The format is `MAJOR.MINOR.PATCH+BUILD` (e.g., `1.2.3+4`).
///
/// All version segments must be non-negative integers.
///
/// ```dart
/// final version = Version.parse('1.2.3+4');
/// print(version.major);           // 1
/// print(version.getStoreVersion()); // 1.2.3
/// print(version.getBuildNumber());  // 4
/// ```
class Version implements IVersion {
  /// Creates a [Version] with the given [major], [minor], [patch], and [build].
  ///
  /// Throws [ArgumentError] if any segment is negative.
  Version(this.major, this.minor, this.patch, this.build) {
    if (major < 0 || minor < 0 || patch < 0 || build < 0) {
      throw ArgumentError('Version numbers must be non-negative');
    }
  }

  /// Parses a version string in the format `MAJOR.MINOR.PATCH` or
  /// `MAJOR.MINOR.PATCH+BUILD`.
  ///
  /// The build number defaults to `0` if not provided.
  ///
  /// Throws [FormatException] if the string is empty or malformed.
  /// Throws [ArgumentError] if any parsed segment is negative.
  factory Version.parse(String version) {
    if (version.isEmpty) {
      throw FormatException('Version string cannot be empty');
    }

    final parts = version.split('+');
    if (parts.length > 2) {
      throw FormatException('Invalid version format: too many + symbols');
    }

    final versionParts = parts[0].split('.');
    if (versionParts.length != 3) {
      throw FormatException(
          'Version must have exactly 3 parts (major.minor.patch)');
    }

    int buildNumber;
    try {
      buildNumber = parts.length > 1 ? int.parse(parts[1]) : 0;
    } catch (e) {
      throw FormatException('Build number must be a valid integer');
    }

    try {
      final parsed = Version(
        int.parse(versionParts[0]),
        int.parse(versionParts[1]),
        int.parse(versionParts[2]),
        buildNumber,
      );
      return parsed;
    } on ArgumentError {
      rethrow;
    } catch (e) {
      throw FormatException('Version parts must be valid integers');
    }
  }

  @override
  final int major;
  @override
  final int minor;
  @override
  final int patch;
  @override
  final int build;

  @override
  String getStoreVersion() => '$major.$minor.$patch';

  @override
  String getBuildNumber() => build.toString();

  @override
  String toString() => '$major.$minor.$patch+$build';
}
