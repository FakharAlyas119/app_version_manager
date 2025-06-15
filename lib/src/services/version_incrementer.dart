import '../interfaces/version_incrementer.dart';
import '../models/version.dart';

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

  @override
  Version autoModifier(Version version) {
    // If build number is less than 99, just increment build
    if (version.build < 99) {
      return Version(
        version.major,
        version.minor,
        version.patch,
        version.build + 1,
      );
    }

    // If patch is less than 99, increment patch and reset build
    if (version.patch < 99) {
      return Version(
        version.major,
        version.minor,
        version.patch + 1,
        version.build + 1,
      );
    }

    // If minor is less than 99, increment minor and reset patch
    if (version.minor < 99) {
      return Version(version.major, version.minor + 1, 0, version.build + 1);
    }

    // Otherwise increment major and reset everything else
    return Version(version.major + 1, 0, 0, version.build + 1);
  }
}
