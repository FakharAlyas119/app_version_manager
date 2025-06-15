import 'package:app_version_manager/src/services/version_revert.dart';
import 'package:app_version_manager/src/utils/logger.dart';
import 'package:app_version_manager/version_manager.dart';
import 'package:test/test.dart';

void main() {
  late Logger logger;
  setUp(() {
    logger = Logger();
    // Initialize logger with appropriate level for tests
    logger.debug('Setting up logger for tests');
  });

  group('VersionCommandFactory tests:', () {
    late IVersionModifier incrementor;
    late IVersionModifier reverter;

    setUp(() {
      incrementor = VersionIncrementor();
      reverter = VersionRevert();
    });

    test('Creates correct increment commands', () {
      // Test major command
      final majorCommand = VersionCommandFactory.create('major', incrementor);
      logger.debug('Created command: ${majorCommand.commandName}');
      expect(majorCommand.commandName, equals('major'));

      final version = Version.parse('1.2.3+4');
      logger.info('Testing with version: $version');
      final majorResult = majorCommand.execute(version);
      logger.info('After major increment: $majorResult');
      expect(majorResult.toString(), equals('2.0.0+5'));

      // Test minor command
      final minorCommand = VersionCommandFactory.create('minor', incrementor);
      logger.debug('Created command: ${minorCommand.commandName}');
      expect(minorCommand.commandName, equals('minor'));

      final minorResult = minorCommand.execute(version);
      logger.info('After minor increment: $minorResult');
      expect(minorResult.toString(), equals('1.3.0+5'));

      // Test patch command
      final patchCommand = VersionCommandFactory.create('patch', incrementor);
      logger.debug('Created command: ${patchCommand.commandName}');
      expect(patchCommand.commandName, equals('patch'));

      final patchResult = patchCommand.execute(version);
      logger.info('After patch increment: $patchResult');
      expect(patchResult.toString(), equals('1.2.4+5'));

      // Test build command
      final buildCommand = VersionCommandFactory.create('build', incrementor);
      logger.debug('Created command: ${buildCommand.commandName}');
      expect(buildCommand.commandName, equals('build'));

      final buildResult = buildCommand.execute(version);
      logger.info('After build increment: $buildResult');
      expect(buildResult.toString(), equals('1.2.3+5'));

      // Test auto increment command
      final autoCommand = VersionCommandFactory.create('bump', incrementor);
      logger.debug('Created command: ${autoCommand.commandName}');
      expect(autoCommand.commandName, equals('bump'));

      final autoResult = autoCommand.execute(version);
      logger.info('After auto increment: $autoResult');
      expect(autoResult.toString(), equals('1.2.3+5')); // Assuming build < 99
    });

    test('Creates correct revert commands', () {
      // Test major revert command
      final majorRevertCommand =
          VersionCommandFactory.create('major revert', reverter);
      logger.debug('Created command: ${majorRevertCommand.commandName}');
      expect(majorRevertCommand.commandName, equals('major revert'));

      final version = Version.parse('2.3.4+5');
      logger.info('Testing with version: $version');
      final majorResult = majorRevertCommand.execute(version);
      logger.info('After major revert: $majorResult');
      expect(majorResult.toString(), equals('1.3.4+5'));

      // Test minor revert command
      final minorRevertCommand =
          VersionCommandFactory.create('minor revert', reverter);
      logger.debug('Created command: ${minorRevertCommand.commandName}');
      expect(minorRevertCommand.commandName, equals('minor revert'));

      final minorResult = minorRevertCommand.execute(version);
      logger.info('After minor revert: $minorResult');
      expect(minorResult.toString(), equals('2.2.4+5'));

      // Test patch revert command
      final patchRevertCommand =
          VersionCommandFactory.create('patch revert', reverter);
      logger.debug('Created command: ${patchRevertCommand.commandName}');
      expect(patchRevertCommand.commandName, equals('patch revert'));

      final patchResult = patchRevertCommand.execute(version);
      logger.info('After patch revert: $patchResult');
      expect(patchResult.toString(), equals('2.3.3+5'));

      // Test build revert command
      final buildRevertCommand =
          VersionCommandFactory.create('build revert', reverter);
      logger.debug('Created command: ${buildRevertCommand.commandName}');
      expect(buildRevertCommand.commandName, equals('build revert'));

      final buildResult = buildRevertCommand.execute(version);
      logger.info('After build revert: $buildResult');
      expect(buildResult.toString(), equals('2.3.4+4')); // Assuming build > 1

      // Test auto revert command
      final autoRevertCommand =
          VersionCommandFactory.create('bump revert', reverter);
      logger.debug('Created command: ${autoRevertCommand.commandName}');
      expect(autoRevertCommand.commandName, equals('bump revert'));

      final autoResult = autoRevertCommand.execute(version);
      logger.info('After auto revert: $autoResult');
      expect(autoResult.toString(), equals('2.3.4+4')); // Assuming build > 1
    });

    test('Throws ArgumentError for invalid commands', () {
      logger.info('Testing invalid commands');
      expect(
        () => VersionCommandFactory.create('invalid', incrementor),
        throwsArgumentError,
      );

      expect(
        () => VersionCommandFactory.create('', incrementor),
        throwsArgumentError,
      );

      expect(
        () => VersionCommandFactory.create('MAJOR', incrementor),
        throwsArgumentError,
      );
    });

    test('Factory creates commands with correct modifier type', () {
      // Test with incrementor
      final majorCommand = VersionCommandFactory.create('major', incrementor);
      final version = Version.parse('1.2.3+4');
      logger.info('Testing with version: $version and incrementor');
      final result = majorCommand.execute(version);
      logger.info('Result with incrementor: $result');
      expect(result.toString(), equals('2.0.0+5')); // Should increment

      // Test with reverter
      final majorRevertCommand =
          VersionCommandFactory.create('major', reverter);
      logger.info('Testing with version: $version and reverter');
      final revertResult = majorRevertCommand.execute(version);
      logger.info('Result with reverter: $revertResult');
      expect(revertResult.toString(), equals('0.2.3+4')); // Should revert
    });
  });
}
