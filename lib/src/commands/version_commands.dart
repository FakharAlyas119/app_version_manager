import '../interfaces/version_command.dart';
import '../interfaces/version_incrementer.dart';
import '../models/version.dart';

class _MajorVersionCommand implements IVersionCommand {
  _MajorVersionCommand(this._modifier);
  final IVersionModifier _modifier;

  @override
  Version execute(Version currentVersion) =>
      _modifier.majorModifier(currentVersion);

  @override
  String get commandName => 'major';
}

class _MinorVersionCommand implements IVersionCommand {
  _MinorVersionCommand(this._modifier);
  final IVersionModifier _modifier;

  @override
  Version execute(Version currentVersion) =>
      _modifier.minorModifier(currentVersion);

  @override
  String get commandName => 'minor';
}

class _PatchVersionCommand implements IVersionCommand {
  _PatchVersionCommand(this._modifier);
  final IVersionModifier _modifier;

  @override
  Version execute(Version currentVersion) =>
      _modifier.patchModifier(currentVersion);

  @override
  String get commandName => 'patch';
}

class _BuildVersionCommand implements IVersionCommand {
  _BuildVersionCommand(this._modifier);
  final IVersionModifier _modifier;

  @override
  Version execute(Version currentVersion) =>
      _modifier.buildModifier(currentVersion);

  @override
  String get commandName => 'build';
}

class _AutoVersionCommand implements IVersionCommand {
  _AutoVersionCommand(this._modifier);
  final IVersionModifier _modifier;

  @override
  Version execute(Version currentVersion) =>
      _modifier.autoModifier(currentVersion);

  @override
  String get commandName => 'bump';
}

class VersionCommandFactory {
  static IVersionCommand create(
    String command,
    IVersionModifier modifier,
  ) {
    // Normalize: strip "revert" suffix since the modifier already handles the strategy
    final baseCommand = command.replaceAll('revert', '').trim();

    switch (baseCommand) {
      case 'major':
        return _MajorVersionCommand(modifier);
      case 'minor':
        return _MinorVersionCommand(modifier);
      case 'patch':
        return _PatchVersionCommand(modifier);
      case 'build':
        return _BuildVersionCommand(modifier);
      case 'bump':
        return _AutoVersionCommand(modifier);
      default:
        throw ArgumentError(
          'Invalid command: $command. Use: major, minor, patch, build, bump (append "revert" to undo, e.g. major revert)',
        );
    }
  }
}
