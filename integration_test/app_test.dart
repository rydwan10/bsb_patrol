import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:bsb_patrol/keys/patrol_keys_explore.dart';
import 'package:bsb_patrol/keys/patrol_keys_home.dart';
import 'package:bsb_patrol/keys/patrol_keys_login.dart';
import 'package:bsb_patrol/keys/patrol_keys_notifications.dart';
import 'package:bsb_patrol/keys/patrol_keys_profile.dart';
import 'package:bsb_patrol/keys/patrol_keys_register.dart';
import 'package:bsb_patrol/main.dart';

// Run all tests:
//   patrol test
//
// Run on a specific device:
//   patrol test --device emulator-5554
//
// Run a single test file:
//   patrol test integration_test/app_test.dart

void main() {
  group('BSB Patrol Demo', () {
    patrolTest(
      'Login flow — valid credentials navigates to home',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Verify login screen is visible
        expect(find.byKey(LoginKeys.loginTitle), findsOneWidget);
        expect(find.byKey(LoginKeys.loginSubtitle), findsOneWidget);

        // Enter email
        await $(LoginKeys.emailField).enterText('officer@bsbpatrol.com');
        await $.pumpAndSettle();

        // Enter password
        await $(LoginKeys.passwordField).enterText('password123');
        await $.pumpAndSettle();

        // Tap Sign In
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        // Verify home screen is shown
        expect(find.byKey(HomeKeys.dashboardHeading), findsOneWidget);
        expect(find.byKey(HomeKeys.dashboardWelcomeGreeting), findsOneWidget);
      },
    );

    patrolTest(
      'Login flow — validation errors shown on empty submit',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Tap Sign In without filling fields
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        // Validation errors should appear
        expect(find.text('Email is required'), findsOneWidget);
        expect(find.text('Password is required'), findsOneWidget);
      },
    );

    patrolTest(
      'Login flow — invalid email shows validation error',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        await $(LoginKeys.emailField).enterText('not-an-email');
        await $(LoginKeys.passwordField).enterText('password123');
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        expect(find.text('Enter a valid email address'), findsOneWidget);
      },
    );

    patrolTest(
      'Navigate to register screen from login',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Tap register link
        await $(LoginKeys.registerLink).tap();
        await $.pumpAndSettle();

        // Verify register screen is shown at step 1
        expect(find.byKey(RegisterKeys.registerAppBarTitle), findsOneWidget);
        expect(find.byKey(RegisterKeys.step1Heading), findsOneWidget);
        expect(find.byKey(RegisterKeys.stepCounter), findsOneWidget);
      },
    );

    patrolTest(
      'Register flow — Step 1 validation',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        await $(LoginKeys.registerLink).tap();
        await $.pumpAndSettle();

        // Try to proceed without filling step 1
        await $(RegisterKeys.nextStep1Button).tap();
        await $.pumpAndSettle();

        // Validation errors
        expect(find.text('First name is required'), findsOneWidget);
      },
    );

    patrolTest(
      'Register flow — complete 3-step registration',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Navigate to register
        await $(LoginKeys.registerLink).tap();
        await $.pumpAndSettle();

        // ── Step 1: Personal Info ──
        expect(find.byKey(RegisterKeys.step1Heading), findsOneWidget);

        await $(RegisterKeys.firstNameField).enterText('Jane');
        await $.pumpAndSettle();
        await $(RegisterKeys.lastNameField).enterText('Smith');
        await $.pumpAndSettle();
        await $(RegisterKeys.registerEmailField)
            .enterText('jane@bsbpatrol.com');
        await $.pumpAndSettle();
        await $(RegisterKeys.phoneField).enterText('+1 555 000 1234');
        await $.pumpAndSettle();

        await $(RegisterKeys.nextStep1Button).tap();
        await $.pumpAndSettle();

        // ── Step 2: Account Setup ──
        expect(find.byKey(RegisterKeys.step2Heading), findsOneWidget);

        await $(RegisterKeys.usernameField).enterText('janesmith');
        await $.pumpAndSettle();
        await $(RegisterKeys.registerPasswordField).enterText('SecurePass1!');
        await $.pumpAndSettle();
        await $(RegisterKeys.confirmPasswordField).enterText('SecurePass1!');
        await $.pumpAndSettle();

        await $(RegisterKeys.nextStep2Button).tap();
        await $.pumpAndSettle();

        // ── Step 3: Review ──
        expect(find.byKey(RegisterKeys.step3Heading), findsOneWidget);
        expect(find.byKey(RegisterKeys.reviewFirstNameValue), findsOneWidget);
        expect(find.byKey(RegisterKeys.reviewLastNameValue), findsOneWidget);
        expect(find.byKey(RegisterKeys.reviewEmailValue), findsOneWidget);
        expect(find.byKey(RegisterKeys.reviewUsernameValue), findsOneWidget);

        await $(RegisterKeys.submitButton).tap();
        await $.pumpAndSettle();

        // After successful registration, lands on home screen
        expect(find.byKey(HomeKeys.dashboardHeading), findsOneWidget);
      },
    );

    patrolTest(
      'Register flow — password mismatch shows error',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        await $(LoginKeys.registerLink).tap();
        await $.pumpAndSettle();

        // Fill step 1
        await $(RegisterKeys.firstNameField).enterText('Test');
        await $(RegisterKeys.lastNameField).enterText('User');
        await $(RegisterKeys.registerEmailField).enterText('test@test.com');
        await $(RegisterKeys.phoneField).enterText('+1 555 000 0000');
        await $(RegisterKeys.nextStep1Button).tap();
        await $.pumpAndSettle();

        // Step 2 with mismatched passwords
        await $(RegisterKeys.usernameField).enterText('testuser');
        await $(RegisterKeys.registerPasswordField).enterText('Password123!');
        await $(RegisterKeys.confirmPasswordField).enterText('DifferentPass!');
        await $(RegisterKeys.nextStep2Button).tap();
        await $.pumpAndSettle();

        expect(find.text('Passwords do not match'), findsOneWidget);
      },
    );

    patrolTest(
      'Home screen — bottom navigation tabs work correctly',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login first
        await $(LoginKeys.emailField).enterText('officer@bsbpatrol.com');
        await $(LoginKeys.passwordField).enterText('password123');
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        // Verify on Dashboard tab
        expect(find.byKey(HomeKeys.dashboardWelcomeGreeting), findsOneWidget);

        // Navigate to Explore tab
        await $(HomeKeys.exploreTab).tap();
        await $.pumpAndSettle();
        expect(find.byKey(ExploreKeys.exploreSubtitle), findsOneWidget);

        // Navigate to Alerts tab
        await $(HomeKeys.notificationsTab).tap();
        await $.pumpAndSettle();
        expect(
            find.byKey(NotificationsKeys.notificationsHeading), findsOneWidget);

        // Navigate to Profile tab
        await $(HomeKeys.profileTab).tap();
        await $.pumpAndSettle();
        expect(find.byKey(ProfileKeys.profileName), findsOneWidget);
        expect(find.byKey(ProfileKeys.profileUsername), findsOneWidget);

        // Navigate back to Dashboard
        await $(HomeKeys.dashboardTab).tap();
        await $.pumpAndSettle();
        expect(find.byKey(HomeKeys.dashboardWelcomeGreeting), findsOneWidget);
      },
    );

    patrolTest(
      'Profile — logout navigates back to login',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login
        await $(LoginKeys.emailField).enterText('officer@bsbpatrol.com');
        await $(LoginKeys.passwordField).enterText('password123');
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        // Go to Profile tab
        await $(HomeKeys.profileTab).tap();
        await $.pumpAndSettle();

        // Scroll the logout button into view before tapping
        await $(ProfileKeys.logoutButton).scrollTo();
        await $.pumpAndSettle();

        // Tap Sign Out
        await $(ProfileKeys.logoutButton).tap();
        await $.pumpAndSettle();

        // Confirm dialog appears
        expect(find.byKey(ProfileKeys.logoutDialogTitle), findsOneWidget);
        expect(find.byKey(ProfileKeys.logoutDialogMessage), findsOneWidget);

        // Confirm logout
        await $(ProfileKeys.confirmLogoutButton).tap();
        await $.pumpAndSettle();

        // Back on login screen
        expect(find.byKey(LoginKeys.loginSubtitle), findsOneWidget);
      },
    );

    patrolTest(
      'Profile — accept system file access permission when changing profile picture',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login
        await $(LoginKeys.emailField).enterText('officer@bsbpatrol.com');
        await $(LoginKeys.passwordField).enterText('password123');
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        // Go to Profile tab
        await $(HomeKeys.profileTab).tap();
        await $.pumpAndSettle();

        // Tap on the avatar to trigger a native permission dialog
        await $(ProfileKeys.changeProfilePictureButton).tap();
        await $.pumpAndSettle();

        // Handle the native system permission dialog with Patrol - Android Only
        if (await $.platformAutomator.android.isPermissionDialogVisible()) {
          await $.platformAutomator.android.grantPermissionWhenInUse();
        }

        // Give the app a moment to react to the granted permission
        await $.pump(const Duration(seconds: 1));

        // We only assert that we're still on the Profile screen;
        // the system dialog has been handled without crashing.
        expect(find.byKey(ProfileKeys.profileName), findsOneWidget);
        expect(find.byKey(ProfileKeys.profileUsername), findsOneWidget);
      },
    );

    patrolTest(
      'Notifications — mark all as read',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login
        await $(LoginKeys.emailField).enterText('officer@bsbpatrol.com');
        await $(LoginKeys.passwordField).enterText('password123');
        await $(LoginKeys.loginButton).tap();
        await $.pumpAndSettle();

        // Go to Alerts tab
        await $(HomeKeys.notificationsTab).tap();
        await $.pumpAndSettle();

        // Verify unread badge exists
        expect(find.byKey(NotificationsKeys.unreadCountBadge), findsOneWidget);

        // Tap mark all read
        await $(NotificationsKeys.markAllReadButton).tap();
        await $.pumpAndSettle();

        // Badge and button should be gone
        expect(find.byKey(NotificationsKeys.unreadCountBadge), findsNothing);
        expect(find.byKey(NotificationsKeys.markAllReadButton), findsNothing);
      },
    );
  });
}
