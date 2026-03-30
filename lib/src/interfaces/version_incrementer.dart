import 'package:app_version_manager/src/services/version_revert.dart';
import 'package:app_version_manager/app_version_manager.dart';

/// Strategy interface for modifying version numbers.
///
/// Two built-in implementations are provided:
/// - [VersionIncrementor] increments version segments.
/// - [VersionRevert] decrements version segments.
///
/// Use the factory constructor to automatically select the correct strategy
/// based on the command string.
abstract class IVersionModifier {
  /// Modifies the [version] major segment.
  Version majorModifier(Version version);

  /// Modifies the [version] minor segment.
  Version minorModifier(Version version);

  /// Modifies the [version] patch segment.
  Version patchModifier(Version version);

  /// Modifies the [version] build segment.
  Version buildModifier(Version version);

  /// Applies smart auto-modification logic to [version].
  ///
  /// For increment: cascades from build to patch to minor to major at 99.
  /// For revert: reverses the cascade logic.
  Version autoModifier(Version version);

  /// Creates a [VersionIncrementor] or [VersionRevert] based on [command].
  ///
  /// If [command] ends with `'revert'`, returns a [VersionRevert].
  /// Otherwise, returns a [VersionIncrementor].
  ///
  /// ```dart
  /// final modifier = IVersionModifier('major');        // VersionIncrementor
  /// final reverter = IVersionModifier('major revert'); // VersionRevert
  /// ```
  factory IVersionModifier(String command) {
    final revertPostFix = 'revert'.toLowerCase();
    final commandName = command.toLowerCase();

    if (commandName.endsWith(revertPostFix)) {
      return VersionRevert();
    } else {
      return VersionIncrementor();
    }
  }
}
