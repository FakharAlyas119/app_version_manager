import '../interfaces/version_interface.dart';

class Version implements IVersion {
  Version(this.major, this.minor, this.patch, this.build);

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
      return Version(
        int.parse(versionParts[0]),
        int.parse(versionParts[1]),
        int.parse(versionParts[2]),
        buildNumber,
      );
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
