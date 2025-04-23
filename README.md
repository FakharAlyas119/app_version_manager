# Version Manager

**A simple CLI tool to manage version numbers in Flutter applications.**

---

## ✨ Features

- 🚀 One-line version updates
- 🔢 Supports major, minor, patch, build, and smart bumps
- 📦 Seamless integration into any Flutter project
- 🎯 Follows App Store & Play Store versioning conventions

---

## 📦 Installation

### ✅ Option 1: Global Activation (WIP)

```bash
dart pub global activate app_version_manager
```

> Now you can run `version_bump` from anywhere.

---

### 🛠️ Option 2: As a Dev Dependency

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  app_version_manager: ^1.0.0
```

Then run:

```bash
flutter pub get
```
Run these commands from your Flutter project directory:

```bash
flutter pub run app_version_manager:version_manager major
flutter pub run app_version_manager:version_manager minor
flutter pub run app_version_manager:version_manager patch
flutter pub run app_version_manager:version_manager build
flutter pub run app_version_manager:version_manager bump
```
---

### 🔗 Option 3: From Git Repository

```yaml
dependencies:
  app_version_manager:
    git:
      url: https://github.com/FakharAlyas119/app_version_manager.git
      ref: main
```

---

## 🚀 Usage

Run these commands from your Flutter project directory:

```bash
flutter pub run app_version_manager:version_manager major
flutter pub run app_version_manager:version_manager minor
flutter pub run app_version_manager:version_manager patch
flutter pub run app_version_manager:version_manager build
flutter pub run app_version_manager:version_manager bump
```

---

## 🧠 Smart Increment Logic (`version_bump bump`)

| Current State        | Result                          |
|----------------------|----------------------------------|
| Build < 99           | Increment build only             |
| Patch < 99           | Increment patch + build          |
| Minor < 99           | Increment minor, reset patch, build +1 |
| Otherwise            | Increment major, reset others, build +1 |

---

## 🧾 Version Format

```
MAJOR.MINOR.PATCH+BUILD
```

- **App Store Version:** `MAJOR.MINOR.PATCH`
- **Play Store:**
  - `versionName`: `MAJOR.MINOR.PATCH`
  - `versionCode`: `BUILD`

---





## ⚙️ How It Works

1. Reads the current version from `pubspec.yaml`
2. Increments the appropriate segment
3. Updates `pubspec.yaml` with the new version
4. Displays colorful, clear output of changes

No additional setup required 🎉

---

## 🙌 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

---

## 💬 Support

If you find this useful, ⭐️ the repo or [open an issue](https://github.com/yourusername/app_version_manager/issues) for feature requests or bugs.

