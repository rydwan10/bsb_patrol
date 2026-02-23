# BSB Patrol 🛡️

> **Belajar Sambil Beramal — GDG Bandung 2026** 🌙  
> A demo Flutter project for the Ramadan tech session, showcasing how to write **Patrol integration tests** with a real-world UI built on [shadcn_ui](https://pub.dev/packages/shadcn_ui).

---

## About This Project

This project was created as a hands-on demo for **GDG Bandung's Belajar Sambil Beramal (BSB) 2026** — a community event that combines learning with charity during the Ramadan month. The goal is simple: **learn how to write meaningful integration tests** using [Patrol](https://patrol.leancode.co/) on a Flutter app that looks and feels like a real product.

### What's Inside

| Screen | Description |
|---|---|
| 🔐 **Login** | Email & password form with validation |
| 📝 **Register** | 3-step form (Personal Info → Account Setup → Review) |
| 🏠 **Home** | 4-tab bottom navigation (Dashboard, Explore, Alerts, Profile) |

### Tech Stack

- **Flutter** — UI framework
- **shadcn_ui** — Beautiful, customizable UI components
- **Patrol** — Integration testing framework with native automation support

---

## Prerequisites

Make sure you have the following installed before getting started:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.6.0`
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) (for running on device/emulator)
- [patrol_cli](https://pub.dev/packages/patrol_cli) — Patrol's command-line tool

Install `patrol_cli` globally:

```bash
dart pub global activate patrol_cli
```

Verify your setup:

```bash
patrol --version
# Expected: patrol_cli 4.1.0 or later
```

---

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd bsb_patrol
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
# Run on connected device or emulator
flutter run

# Run on a specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

---

## Running the Tests

This project uses **Patrol** for integration tests. There are two ways to run them depending on your needs.

### Option A — Flutter Test (Quick, no device needed)

Standard Flutter integration test runner. Great for CI or quick local checks.

```bash
flutter test integration_test/app_test.dart
```

### Option B — Patrol CLI (Full native automation, recommended)

Runs tests with full native UI automation support on a real device or emulator.

#### Android

```bash
# Run all integration tests
patrol test

# Run a specific test file
patrol test -t integration_test/app_test.dart

# Run on a specific device
patrol test -t integration_test/app_test.dart --device emulator-5554
```

#### iOS

```bash
patrol test -t integration_test/app_test.dart --device <ios-device-id>
```

> 💡 **Tip:** If you have multiple devices connected, Patrol will prompt you to choose one interactively.

---

## Test Coverage

The integration tests cover the following scenarios:

| # | Test | What It Verifies |
|---|---|---|
| 1 | Login — valid credentials | Navigates to home screen after login |
| 2 | Login — empty submit | Validation errors appear |
| 3 | Login — invalid email | Email format error shown |
| 4 | Navigate to register | Opens register screen at Step 1 |
| 5 | Register — Step 1 validation | Required field errors on empty submit |
| 6 | Register — full 3-step flow | Completes all steps and lands on home |
| 7 | Register — password mismatch | Mismatch error shown |
| 8 | Bottom nav tabs | All 4 tabs navigate correctly |
| 9 | Profile — logout flow | Logout dialog → confirm → back to login |
| 10 | Notifications — mark all read | Unread badge disappears |

---

## Project Structure

```
bsb_patrol/
├── lib/
│   ├── main.dart                        # App entry point (ShadApp)
│   └── screens/
│       ├── login_screen.dart            # Login page
│       ├── register_screen.dart         # 3-step registration
│       ├── home_screen.dart             # Bottom navigation shell
│       └── tabs/
│           ├── dashboard_tab.dart       # Dashboard with stats & activity
│           ├── explore_tab.dart         # Searchable zones/officers list
│           ├── notifications_tab.dart   # Notification feed
│           └── profile_tab.dart         # User profile & logout
├── integration_test/
│   └── app_test.dart                    # Patrol integration tests
└── android/
    └── app/
        └── src/
            └── androidTest/
                └── java/.../
                    └── MainActivityTest.java  # Android Patrol runner
```

---

## Android Setup Notes

The Android test runner is already configured. Key files:

- **`android/app/src/main/kotlin/.../MainActivity.kt`** — Extends `FlutterFragmentActivity` (required by Patrol)
- **`android/app/src/androidTest/java/.../MainActivityTest.java`** — JUnit runner wired to Patrol
- **`android/app/build.gradle.kts`** — `PatrolJUnitRunner` and `ANDROIDX_TEST_ORCHESTRATOR` configured

---

## Troubleshooting

**`patrol_cli` version mismatch?**
```bash
# Check compatibility
patrol --version
# Then activate the matching version
dart pub global activate patrol_cli 4.1.0
```

**Test bundle using wrong path?**  
Make sure `pubspec.yaml` has `test_directory: integration_test` under the `patrol:` section. This project already has it configured.

**Emulator not found?**  
Run `flutter devices` to list available devices and use the ID with `--device`.

---

## Resources

- 📖 [Patrol Documentation](https://patrol.leancode.co/documentation)
- 🎨 [shadcn_ui for Flutter](https://pub.dev/packages/shadcn_ui)
- 💙 [Flutter Documentation](https://docs.flutter.dev/)
- 🤝 [GDG Bandung Community](https://gdg.community.dev/gdg-bandung/)

---

<div align="center">

Made with ❤️ for **GDG Bandung — Belajar Sambil Beramal Ramadan 2026**

*Semoga bermanfaat dan berkah* 🌙

</div>
