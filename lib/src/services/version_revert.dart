import 'package:app_version_manager/version_manager.dart';

class VersionRevert implements IVersionModifier {
  @override
  Version majorModifier(Version version) {
    // Decrement major version, but ensure it doesn't go below 0
    final major = version.major > 0 ? version.major - 1 : 0;
    return Version(major, version.minor, version.patch, version.build);
  }

  @override
  Version minorModifier(Version version) {
    // Decrement minor version, but ensure it doesn't go below 0
    final minor = version.minor > 0 ? version.minor - 1 : 0;
    return Version(version.major, minor, version.patch, version.build);
  }

  @override
  Version patchModifier(Version version) {
    // Decrement patch version, but ensure it doesn't go below 0
    final patch = version.patch > 0 ? version.patch - 1 : 0;
    return Version(version.major, version.minor, patch, version.build);
  }

  @override
  Version buildModifier(Version version) {
    // Decrement build version, but ensure it doesn't go below 1
    final build = version.build > 1 ? version.build - 1 : 1;
    return Version(version.major, version.minor, version.patch, build);
  }

  @override
  Version autoModifier(Version version) {
    // Implement smart revert logic - reverse of autoIncrement

    // If build is greater than 1, just decrement build
    if (version.build > 1) {
      return Version(
        version.major,
        version.minor,
        version.patch,
        version.build - 1,
      );
    }

    // If patch is greater than 0, decrement patch and set build to 99
    if (version.patch > 0) {
      return Version(
        version.major,
        version.minor,
        version.patch - 1,
        99,
      );
    }

    // If minor is greater than 0, decrement minor, set patch to 99, and build to 99
    if (version.minor > 0) {
      return Version(version.major, version.minor - 1, 99, 99);
    }

    // If major is greater than 0, decrement major, set minor and patch to 99, and build to 99
    if (version.major > 0) {
      return Version(version.major - 1, 99, 99, 99);
    }

    // If we can't revert any further, return the original version
    return version;
  }
}
