import 'package:app_version_manager/version_manager.dart';

void main() {
  // Create a version
  final version = Version.parse('1.2.3+4');
  print('Original version: $version');

  // Increment version
  final incrementor = VersionIncrementor();
  final newVersion = incrementor.patchModifier(version);
  print('New version after patch increment: $newVersion');

  // Demonstrate other increments
  print('After major increment: ${incrementor.majorModifier(version)}');
  print('After minor increment: ${incrementor.minorModifier(version)}');
  print('After build increment: ${incrementor.buildModifier(version)}');
}
