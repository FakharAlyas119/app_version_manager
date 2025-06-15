import 'package:app_version_manager/src/services/version_revert.dart';
import 'package:app_version_manager/version_manager.dart';
import 'package:test/test.dart';

void main() {
  group('Version tests: ', () {
    test('Version parsing works correctly', () {
      final version = Version.parse('1.2.3+4');
      print('Parsed version: $version');
      print(
          'Major: ${version.major}, Minor: ${version.minor}, Patch: ${version.patch}, Build: ${version.build}');

      expect(version.major, equals(1));
      expect(version.minor, equals(2));
      expect(version.patch, equals(3));
      expect(version.build, equals(4));
    });

    test('Version reverting works correctly', () {
      final version = Version.parse('2.3.4+5');
      print('Original version: $version');
      final reverter = VersionRevert();

      final majorVersion = reverter.majorModifier(version);
      print('After major revert: $majorVersion');
      expect(majorVersion.toString(), equals('1.3.4+5'));

      final minorVersion = reverter.minorModifier(version);
      print('After minor revert: $minorVersion');
      expect(minorVersion.toString(), equals('2.2.4+5'));

      final patchVersion = reverter.patchModifier(version);
      print('After patch revert: $patchVersion');
      expect(patchVersion.toString(), equals('2.3.3+5'));

      final buildVersion = reverter.buildModifier(version);
      print('After build revert: $buildVersion');
      expect(buildVersion.toString(), equals('2.3.4+4'));
    });

    test('Version auto-revert works correctly', () {
      final reverter = VersionRevert();

      // Test case 1: Only build number decreases
      final version1 = Version.parse('1.2.3+5');
      final result1 = reverter.autoModifier(version1);
      expect(result1.toString(), equals('1.2.3+4'));

      // Test case 2: Build is 1, so patch decreases and build goes to 99
      final version2 = Version.parse('1.2.3+1');
      final result2 = reverter.autoModifier(version2);
      expect(result2.toString(), equals('1.2.2+99'));

      // Test case 3: Patch is 0, so minor decreases, patch goes to 99, build to 99
      final version3 = Version.parse('1.2.0+1');
      final result3 = reverter.autoModifier(version3);
      expect(result3.toString(), equals('1.1.99+99'));

      // Test case 4: Minor is 0, so major decreases, minor and patch go to 99, build to 99
      final version4 = Version.parse('2.0.0+1');
      final result4 = reverter.autoModifier(version4);
      expect(result4.toString(), equals('1.99.99+99'));

      // Test case 5: Cannot revert any further (all at minimum)
      final version5 = Version.parse('0.0.0+1');
      final result5 = reverter.autoModifier(version5);
      expect(result5.toString(), equals('0.0.0+1'));
    });

    test('Version revert handles edge cases', () {
      final reverter = VersionRevert();

      // Test with minimum version numbers
      final minVersion = Version.parse('0.0.0+1');
      expect(reverter.majorModifier(minVersion).toString(), equals('0.0.0+1'));
      expect(reverter.minorModifier(minVersion).toString(), equals('0.0.0+1'));
      expect(reverter.patchModifier(minVersion).toString(), equals('0.0.0+1'));
      expect(reverter.buildModifier(minVersion).toString(), equals('0.0.0+1'));

      // Test with large version numbers
      final largeVersion = Version.parse('999.999.999+999');
      expect(reverter.majorModifier(largeVersion).toString(),
          equals('998.999.999+999'));
      expect(reverter.minorModifier(largeVersion).toString(),
          equals('999.998.999+999'));
      expect(reverter.patchModifier(largeVersion).toString(),
          equals('999.999.998+999'));
      expect(reverter.buildModifier(largeVersion).toString(),
          equals('999.999.999+998'));
    });

    test('Version revert maintains version integrity', () {
      final incrementor = VersionIncrementor();
      final reverter = VersionRevert();
      final version = Version.parse('1.2.3+4');

      // Increment then revert should return to original
      final incremented = incrementor.majorModifier(version);
      final reverted = reverter.majorModifier(incremented);
      expect(reverted.toString(), equals('1.0.0+5'));

      // Multiple reverts work correctly
      final doubleRevert = reverter
          .minorModifier(reverter.majorModifier(Version.parse('3.2.1+5')));
      expect(doubleRevert.toString(), equals('2.1.1+5'));

      // Mixed operations maintain integrity
      final mixedOps = reverter.patchModifier(
          incrementor.minorModifier(reverter.majorModifier(version)));
      expect(mixedOps.toString(), equals('0.3.0+5'));
    });

    group('Exception handling tests', () {
      test('Throws FormatException for invalid version string', () {
        expect(
          () => Version.parse('invalid.version'),
          throwsA(isA<FormatException>()),
        );
        expect(
          () => Version.parse('1.2.x'),
          throwsA(isA<FormatException>()),
        );
        expect(
          () => Version.parse('1.2.3+x'),
          throwsA(isA<FormatException>()),
        );
      });

      test('Throws ArgumentError for null or empty version string', () {
        expect(
          () => Version.parse(''),
          throwsA(isA<FormatException>()),
        );
      });

      test('Handles missing build number correctly', () {
        final version = Version.parse('1.2.3');
        expect(version.major, equals(1));
        expect(version.minor, equals(2));
        expect(version.patch, equals(3));
        expect(version.build, equals(0)); // Default build number should be 0
      });

      test('VersionIncrementor handles edge cases', () {
        final incrementor = VersionIncrementor();
        final version = Version.parse('0.0.0+0');

        // Test with minimum version numbers
        expect(
            incrementor.majorModifier(version).toString(), equals('1.0.0+1'));
        expect(
            incrementor.minorModifier(version).toString(), equals('0.1.0+1'));
        expect(
            incrementor.patchModifier(version).toString(), equals('0.0.1+1'));
        expect(
            incrementor.buildModifier(version).toString(), equals('0.0.0+1'));

        // Test with large version numbers
        final largeVersion = Version.parse('999.999.999+999');
        expect(incrementor.majorModifier(largeVersion).toString(),
            equals('1000.0.0+1000'));
        expect(incrementor.minorModifier(largeVersion).toString(),
            equals('999.1000.0+1000'));
        expect(incrementor.patchModifier(largeVersion).toString(),
            equals('999.999.1000+1000'));
        expect(incrementor.buildModifier(largeVersion).toString(),
            equals('999.999.999+1000'));
      });

      test('VersionIncrementor maintains version integrity', () {
        final incrementor = VersionIncrementor();
        final version = Version.parse('1.2.3+4');

        // Verify that multiple increments work correctly
        final doubleIncrement =
            incrementor.majorModifier(incrementor.majorModifier(version));
        expect(doubleIncrement.toString(), equals('3.0.0+6'));

        // Verify that different increment combinations work
        final mixedIncrement = incrementor.patchModifier(
            incrementor.minorModifier(incrementor.majorModifier(version)));
        expect(mixedIncrement.toString(), equals('2.1.1+7'));
      });
    });
  });
}
