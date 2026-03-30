/// Interface representing an application version with semantic versioning.
///
/// A version consists of [major], [minor], [patch], and [build] segments
/// following the format `MAJOR.MINOR.PATCH+BUILD`.
abstract class IVersion {
  /// The major version number (breaking changes).
  int get major;

  /// The minor version number (new features, backward-compatible).
  int get minor;

  /// The patch version number (bug fixes).
  int get patch;

  /// The build number used as Play Store `versionCode`.
  int get build;

  /// Returns the store version string (`MAJOR.MINOR.PATCH`).
  ///
  /// Used as the iOS App Store `CFBundleShortVersionString`
  /// and Android `versionName`.
  String getStoreVersion();

  /// Returns the build number as a string.
  ///
  /// Used as the Android Play Store `versionCode`.
  String getBuildNumber();
}
