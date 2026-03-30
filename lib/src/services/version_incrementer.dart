import '../interfaces/version_incrementer.dart';
import '../models/version.dart';

/// Increments version segments.
///
/// Each modifier increments its target segment and resets lower segments
/// to zero, while also incrementing the build number.
///
/// ```dart
/// final inc = VersionIncrementor();
/// final v = Version.parse('1.2.3+4');
/// print(inc.majorModifier(v)); // 2.0.0+5
/// print(inc.minorModifier(v)); // 1.3.0+5
/// print(inc.patchModifier(v)); // 1.2.4+5
/// print(inc.buildModifier(v)); // 1.2.3+5
/// ```
class VersionIncrementor implements IVersionModifier {
  @override
  Version majorModifier(Version version) {
    return Version(version.major + 1, 0, 0, version.build + 1);
  }

  @override
  Version minorModifier(Version version) {
    return Version(version.major, version.minor + 1, 0, version.build + 1);
  }

  @override
  Version patchModifier(Version version) {
    return Version(
      version.major,
      version.minor,
      version.patch + 1,
      version.build + 1,
    );
  }

  @override
  Version buildModifier(Version version) {
    return Version(
      version.major,
      version.minor,
      version.patch,
      version.build + 1,
    );
  }

  /// Smart auto-increment that cascades when a segment reaches 99.
  ///
  /// - Build < 99: increment build only.
  /// - Build >= 99, Patch < 99: increment patch, reset build to 1.
  /// - Patch >= 99, Minor < 99: increment minor, reset patch and build.
  /// - Otherwise: increment major, reset all others.
  @override
  Version autoModifier(Version version) {
    if (version.build < 99) {
      return Version(
        version.major,
        version.minor,
        version.patch,
        version.build + 1,
      );
    }

    if (version.patch < 99) {
      return Version(version.major, version.minor, version.patch + 1, 1);
    }

    if (version.minor < 99) {
      return Version(version.major, version.minor + 1, 0, 1);
    }

    return Version(version.major + 1, 0, 0, 1);
  }
}
