import '../models/version.dart';

abstract class IFileManager {
  Version getCurrentVersion();
  void updateVersion(Version version);
}
