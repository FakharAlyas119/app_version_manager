import '../models/version.dart';

abstract class IVersionIncrementor {
  Version incrementMajor(Version version);
  Version incrementMinor(Version version);
  Version incrementPatch(Version version);
  Version incrementBuild(Version version);
  Version autoIncrement(Version version);
}
