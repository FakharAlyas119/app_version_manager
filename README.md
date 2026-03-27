# App Version Manager

**A simple CLI tool to manage version numbers in Flutter applications.**

---

## Features

- One-line version updates from the terminal
- Supports major, minor, patch, build, and smart bumps
- Revert any version segment back with `revert` commands
- Validates version numbers (no negatives allowed)
- Seamless integration into any Flutter project
- Follows App Store & Play Store versioning conventions

---

## Installation

### Option 1: From pub.dev

```bash
dart pub global activate app_version_manager
```

### Option 2: Global Activation from GitHub

```bash
dart pub global activate --source git https://github.com/FakharAlyas119/app_version_manager.git
```

### Option 3: As a Dev Dependency

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  app_version_manager: ^2.0.0
```

Then run:

```bash
dart pub get
```

---

## Usage

### Increment Commands

If installed globally, run from your Flutter project directory:

```bash
version_bump major    # 1.2.3+4 -> 2.0.0+5
version_bump minor    # 1.2.3+4 -> 1.3.0+5
version_bump patch    # 1.2.3+4 -> 1.2.4+5
version_bump build    # 1.2.3+4 -> 1.2.3+5
version_bump bump     # Smart auto-increment (see below)
```

### Revert Commands

Undo a version bump by appending `revert`:

```bash
version_bump major revert    # 2.3.4+5 -> 1.3.4+4
version_bump minor revert    # 2.3.4+5 -> 2.2.4+4
version_bump patch revert    # 2.3.4+5 -> 2.3.3+4
version_bump build revert    # 2.3.4+5 -> 2.3.4+4
version_bump bump revert     # Smart auto-revert
```

### As a Dev Dependency

```bash
dart run app_version_manager:app_version_manager major
dart run app_version_manager:app_version_manager minor revert
```

---

## Smart Increment Logic (`version_bump bump`)

| Current State | Result                                       |
|---------------|----------------------------------------------|
| Build < 99    | Increment build only                         |
| Build >= 99, Patch < 99 | Increment patch, reset build to 1  |
| Patch >= 99, Minor < 99 | Increment minor, reset patch & build |
| Otherwise     | Increment major, reset all others            |

### Smart Revert Logic (`version_bump bump revert`)

| Current State | Result                                       |
|---------------|----------------------------------------------|
| Build > 1     | Decrement build only                         |
| Patch > 0     | Decrement patch, set build to 99             |
| Minor > 0     | Decrement minor, set patch & build to 99     |
| Major > 0     | Decrement major, set minor, patch & build to 99 |

---

## Version Format

```
MAJOR.MINOR.PATCH+BUILD
```

- **App Store Version:** `MAJOR.MINOR.PATCH`
- **Play Store:**
  - `versionName`: `MAJOR.MINOR.PATCH`
  - `versionCode`: `BUILD`

---

## How It Works

1. Reads the current version from `pubspec.yaml`
2. Applies the requested increment or revert operation
3. Updates `pubspec.yaml` with the new version
4. Displays colorful, clear output of changes

---

## Programmatic Usage

You can also use the library in your own Dart code:

```dart
import 'package:app_version_manager/app_version_manager.dart';

void main() {
  final version = Version.parse('1.2.3+4');
  final incrementor = VersionIncrementor();

  print(incrementor.majorModifier(version)); // 2.0.0+5
  print(incrementor.minorModifier(version)); // 1.3.0+5
  print(incrementor.patchModifier(version)); // 1.2.4+5
  print(incrementor.buildModifier(version)); // 1.2.3+5
}
```

---

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

---

## License

[MIT](LICENSE)
