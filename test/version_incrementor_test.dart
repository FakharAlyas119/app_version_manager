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

    test('Version incrementing works correctly', () {
      final version = Version.parse('1.2.3+4');
      print('Original version: $version');
      final incrementor = VersionIncrementor();

      final majorVersion = incrementor.majorModifier(version);
      print('After major increment: $majorVersion');
      expect(majorVersion.toString(), equals('2.0.0+5'));

      final minorVersion = incrementor.minorModifier(version);
      print('After minor increment: $minorVersion');
      expect(minorVersion.toString(), equals('1.3.0+5'));

      final patchVersion = incrementor.patchModifier(version);
      print('After patch increment: $patchVersion');
      expect(patchVersion.toString(), equals('1.2.4+5'));

      final buildVersion = incrementor.buildModifier(version);
      print('After build increment: $buildVersion');
      expect(buildVersion.toString(), equals('1.2.3+5'));
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
