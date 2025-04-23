import '../models/version.dart';

abstract class IVersionCommand {
  Version execute(Version currentVersion);
  String get commandName;
}
