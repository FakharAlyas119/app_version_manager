/// Example demonstrating how to use the app_version_manager library.
///
/// This example shows version parsing, incrementing, reverting,
/// and the smart auto-increment/revert logic.
library;

import 'package:app_version_manager/app_version_manager.dart';
import 'package:app_version_manager/src/services/version_revert.dart';

void main() {
  // Parse a version string
  final version = Version.parse('1.2.3+4');
  print('Original version: $version'); // 1.2.3+4
  print('Store version: ${version.getStoreVersion()}'); // 1.2.3
  print('Build number: ${version.getBuildNumber()}'); // 4

  // --- Increment examples ---
  final incrementor = VersionIncrementor();

  print('\n--- Increment ---');
  print('Major: ${incrementor.majorModifier(version)}'); // 2.0.0+5
  print('Minor: ${incrementor.minorModifier(version)}'); // 1.3.0+5
  print('Patch: ${incrementor.patchModifier(version)}'); // 1.2.4+5
  print('Build: ${incrementor.buildModifier(version)}'); // 1.2.3+5
  print('Bump:  ${incrementor.autoModifier(version)}'); // 1.2.3+5

  // --- Revert examples ---
  final reverter = VersionRevert();

  print('\n--- Revert ---');
  print('Major: ${reverter.majorModifier(version)}'); // 0.2.3+3
  print('Minor: ${reverter.minorModifier(version)}'); // 1.1.3+3
  print('Patch: ${reverter.patchModifier(version)}'); // 1.2.2+3
  print('Build: ${reverter.buildModifier(version)}'); // 1.2.3+3
  print('Bump:  ${reverter.autoModifier(version)}'); // 1.2.3+3

  // --- Using the command factory ---
  final modifier = IVersionModifier('patch');
  final command = VersionCommandFactory.create('patch', modifier);
  final result = command.execute(version);
  print('\nCommand factory (patch): $result'); // 1.2.4+5

  // --- Using revert via the factory ---
  final revertModifier = IVersionModifier('patch revert');
  final revertCommand =
      VersionCommandFactory.create('patch revert', revertModifier);
  final revertResult = revertCommand.execute(version);
  print('Command factory (patch revert): $revertResult'); // 1.2.2+3
}
