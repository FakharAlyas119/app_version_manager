import '../interfaces/version_command.dart';
import '../interfaces/version_incrementer.dart';
import '../models/version.dart';

class _MajorVersionCommand implements IVersionCommand {
  _MajorVersionCommand(this._incrementor);
  final IVersionIncrementor _incrementor;

  @override
  Version execute(Version currentVersion) =>
      _incrementor.incrementMajor(currentVersion);

  @override
  String get commandName => 'major';
}

class _MinorVersionCommand implements IVersionCommand {
  _MinorVersionCommand(this._incrementor);
  final IVersionIncrementor _incrementor;

  @override
  Version execute(Version currentVersion) =>
      _incrementor.incrementMinor(currentVersion);

  @override
  String get commandName => 'minor';
}

class _PatchVersionCommand implements IVersionCommand {
  _PatchVersionCommand(this._incrementor);
  final IVersionIncrementor _incrementor;

  @override
  Version execute(Version currentVersion) =>
      _incrementor.incrementPatch(currentVersion);

  @override
  String get commandName => 'patch';
}

class _BuildVersionCommand implements IVersionCommand {
  _BuildVersionCommand(this._incrementor);
  final IVersionIncrementor _incrementor;

  @override
  Version execute(Version currentVersion) =>
      _incrementor.incrementBuild(currentVersion);

  @override
  String get commandName => 'build';
}

class _AutoIncrementVersionCommand implements IVersionCommand {
  _AutoIncrementVersionCommand(this._incrementor);
  final IVersionIncrementor _incrementor;

  @override
  Version execute(Version currentVersion) =>
      _incrementor.autoIncrement(currentVersion);

  @override
  String get commandName => 'bump';
}

class VersionCommandFactory {
  static IVersionCommand create(
    String command,
    IVersionIncrementor _incrementor,
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
      default:
        throw ArgumentError(
          'Invalid command  $command. Use: major, minor, patch, build, or bump',
        );
    }
  }
}
