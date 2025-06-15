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

class _AutoIncrementVersionCommand implements IVersionCommand {
  _AutoIncrementVersionCommand(this._modifier);
  final IVersionModifier _modifier;

  @override
  Version execute(Version currentVersion) =>
      _modifier.autoModifier(currentVersion);

  @override
  String get commandName => 'bump';
}

class _MajorRevertVersionCommand implements IVersionCommand {
  _MajorRevertVersionCommand(this._modifier);
  final IVersionModifier _modifier;
  @override
  Version execute(Version currentVersion) =>
      _modifier.majorModifier(currentVersion);
  @override
  String get commandName => 'major revert';
}

class _MinorRevertVersionCommand implements IVersionCommand {
  _MinorRevertVersionCommand(this._modifier);
  final IVersionModifier _modifier;
  @override
  Version execute(Version currentVersion) =>
      _modifier.minorModifier(currentVersion);
  @override
  String get commandName => 'minor revert';
}

class _PatchRevertVersionCommand implements IVersionCommand {
  _PatchRevertVersionCommand(this._modifier);
  final IVersionModifier _modifier;
  @override
  Version execute(Version currentVersion) =>
      _modifier.patchModifier(currentVersion);
  @override
  String get commandName => 'patch revert';
}

class _BuildRevertVersionCommand implements IVersionCommand {
  _BuildRevertVersionCommand(this._modifier);
  final IVersionModifier _modifier;
  @override
  Version execute(Version currentVersion) =>
      _modifier.buildModifier(currentVersion);
  @override
  String get commandName => 'build revert';
}

class _AutoRevertVersionCommand implements IVersionCommand {
  _AutoRevertVersionCommand(this._modifier);
  final IVersionModifier _modifier;
  @override
  Version execute(Version currentVersion) =>
      _modifier.autoModifier(currentVersion);
  @override
  String get commandName => 'bump revert';
}

class VersionCommandFactory {
  static IVersionCommand create(
    String command,
    IVersionModifier _incrementor,
  ) {
    switch (command) {
      case 'major':
        return _MajorVersionCommand(_incrementor);
      case 'minor':
        return _MinorVersionCommand(_incrementor);
      case 'patch':
        return _PatchVersionCommand(_incrementor);
      case 'build':
        return _BuildVersionCommand(_incrementor);
      case 'bump':
        return _AutoIncrementVersionCommand(_incrementor);
      case 'major revert':
        return _MajorRevertVersionCommand(_incrementor);
      case 'minor revert':
        return _MinorRevertVersionCommand(_incrementor);
      case 'patch revert':
        return _PatchRevertVersionCommand(_incrementor);
      case 'build revert':
        return _BuildRevertVersionCommand(_incrementor);
      case 'bump revert':
        return _AutoRevertVersionCommand(_incrementor);
      default:
        throw ArgumentError(
          'Invalid command  $command. Use: major, minor, patch, build, or bump',
        );
    }
  }
}
