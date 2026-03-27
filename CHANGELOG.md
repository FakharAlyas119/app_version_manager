# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0] - 2026-03-27

### Breaking Changes

- **Revert commands now decrement build number** along with the target segment (e.g., `major revert` on `2.3.4+5` now gives `1.3.4+4` instead of `1.3.4+5`). This makes increment and revert symmetric inverse operations.
- **Smart auto-increment (`bump`) now resets build to 1** on rollover instead of continuing to increment. For example, `1.2.3+99` now bumps to `1.2.4+1` instead of `1.2.4+100`.
- Removed duplicate revert command classes. The factory now reuses the same command classes with the appropriate modifier strategy.

### Fixed

- **CLI revert commands were completely broken** — the CLI only read `args[0]`, so `version_bump major revert` was treated as `version_bump major` (incrementing instead of reverting). Now all arguments are joined correctly.
- **Process exited with code 0 on errors** — `FormatException` was caught by a handler that did not call `exit(1)`, causing the CLI to report success on failure. All errors now consistently exit with code 1.
- **Negative version numbers were accepted** — `Version.parse("-1.2.3+4")` and `Version(-1, 0, 0, 0)` would silently create invalid versions. The constructor now validates that all fields are non-negative.
- Fixed double-space typo in the invalid command error message.
- Error message now lists revert commands as valid options.

### Improved

- Simplified command architecture by removing 5 redundant revert command classes. The `VersionCommandFactory` now strips the "revert" suffix and delegates to the same command classes, since the modifier (Incrementor vs Revert) already determines the behavior.
- Added `LICENSE` (MIT) file for pub.dev compliance.
- Added `CHANGELOG.md` for version history tracking.
- Renamed library file from `version_manager.dart` to `app_version_manager.dart` to match package name (pub.dev convention).
- Added `repository` field to `pubspec.yaml`.
- Updated `pubspec.yaml` description for better pub.dev discoverability.
- Added `analysis_options.yaml` with recommended lints.

## [1.0.0+2] - 2024

### Added

- Version revert support (`major revert`, `minor revert`, `patch revert`, `build revert`, `bump revert`).
- Smart auto-revert logic that reverses the auto-increment cascade.

### Fixed

- Fixed missed import in `version_manager.dart`.

## [1.0.0] - 2024

### Added

- Initial release of App Version Manager.
- CLI tool (`version_bump`) for managing Flutter app versions.
- Supports `major`, `minor`, `patch`, `build`, and `bump` (smart auto-increment) commands.
- Reads and updates `pubspec.yaml` version field automatically.
- SOLID architecture with Strategy, Command, and Factory patterns.
- Colorful terminal output via Logger utility.
- Comprehensive test suite for incrementor, revert, and command factory.
- Example usage file.
