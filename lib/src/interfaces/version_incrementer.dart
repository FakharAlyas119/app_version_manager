import 'package:app_version_manager/src/services/version_revert.dart';
import 'package:app_version_manager/version_manager.dart';

abstract class IVersionModifier {
  Version majorModifier(Version version);
  Version minorModifier(Version version);
  Version patchModifier(Version version);
  Version buildModifier(Version version);
  Version autoModifier(Version version);

  factory IVersionModifier(String command) {
    final revertPostFix = 'revert'.toLowerCase();
    final commandName = command.toLowerCase();

    /// check if command have revert at the end that means revert
    if (commandName.endsWith(revertPostFix)) {
      return VersionRevert();
    } else {
      return VersionIncrementor();
    }
  }
}
