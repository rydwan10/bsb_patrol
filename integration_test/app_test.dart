// ignore_for_file: unused_import
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

        // TODO: verify that the login title widget (LoginKeys.loginTitle) is visible
        // TODO: verify that the login subtitle widget (LoginKeys.loginSubtitle) is visible

        // TODO: enter 'officer@bsbpatrol.com' into the email field (LoginKeys.emailField) and wait for UI to settle
        // TODO: enter 'password123' into the password field (LoginKeys.passwordField) and wait for UI to settle
        // TODO: tap the login button (LoginKeys.loginButton) and wait for UI to settle

        // TODO: verify that the dashboard heading (HomeKeys.dashboardHeading) is visible
        // TODO: verify that the dashboard welcome greeting (HomeKeys.dashboardWelcomeGreeting) is visible
      },
    );

    patrolTest(
      'Login flow — validation errors shown on empty submit',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // TODO: tap the login button (LoginKeys.loginButton) without filling any fields and wait for UI to settle

        // TODO: verify that the text 'Email is required' appears on screen
        // TODO: verify that the text 'Password is required' appears on screen
      },
    );

    patrolTest(
      'Login flow — invalid email shows validation error',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // TODO: enter 'not-an-email' into the email field (LoginKeys.emailField)
        // TODO: enter 'password123' into the password field (LoginKeys.passwordField)
        // TODO: tap the login button (LoginKeys.loginButton) and wait for UI to settle

        // TODO: verify that the text 'Enter a valid email address' appears on screen
      },
    );

    patrolTest(
      'Navigate to register screen from login',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // TODO: tap the register link (LoginKeys.registerLink) and wait for UI to settle

        // TODO: verify that the register screen app bar title (RegisterKeys.registerAppBarTitle) is visible
        // TODO: verify that the step 1 heading (RegisterKeys.step1Heading) is visible
        // TODO: verify that the step counter widget (RegisterKeys.stepCounter) is visible
      },
    );

    patrolTest(
      'Register flow — Step 1 validation',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // TODO: tap the register link (LoginKeys.registerLink) and wait for UI to settle

        // TODO: tap the next/continue button for step 1 (RegisterKeys.nextStep1Button) without filling fields and wait for UI to settle

        // TODO: verify that the text 'First name is required' appears on screen
      },
    );

    patrolTest(
      'Register flow — complete 3-step registration',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // TODO: tap the register link (LoginKeys.registerLink) and wait for UI to settle

        // ── Step 1: Personal Info ──
        // TODO: verify that the step 1 heading (RegisterKeys.step1Heading) is visible

        // TODO: enter 'Jane' into the first name field (RegisterKeys.firstNameField) and wait for UI to settle
        // TODO: enter 'Smith' into the last name field (RegisterKeys.lastNameField) and wait for UI to settle
        // TODO: enter 'jane@bsbpatrol.com' into the email field (RegisterKeys.registerEmailField) and wait for UI to settle
        // TODO: enter '+1 555 000 1234' into the phone field (RegisterKeys.phoneField) and wait for UI to settle
        // TODO: tap the continue button (RegisterKeys.nextStep1Button) and wait for UI to settle

        // ── Step 2: Account Setup ──
        // TODO: verify that the step 2 heading (RegisterKeys.step2Heading) is visible

        // TODO: enter 'janesmith' into the username field (RegisterKeys.usernameField) and wait for UI to settle
        // TODO: enter 'SecurePass1!' into the password field (RegisterKeys.registerPasswordField) and wait for UI to settle
        // TODO: enter 'SecurePass1!' into the confirm password field (RegisterKeys.confirmPasswordField) and wait for UI to settle
        // TODO: tap the review button (RegisterKeys.nextStep2Button) and wait for UI to settle

        // ── Step 3: Review ──
        // TODO: verify that the step 3 heading (RegisterKeys.step3Heading) is visible
        // TODO: verify that the review first name value (RegisterKeys.reviewFirstNameValue) is visible
        // TODO: verify that the review last name value (RegisterKeys.reviewLastNameValue) is visible
        // TODO: verify that the review email value (RegisterKeys.reviewEmailValue) is visible
        // TODO: verify that the review username value (RegisterKeys.reviewUsernameValue) is visible

        // TODO: tap the submit button (RegisterKeys.submitButton) and wait for UI to settle

        // TODO: verify that the dashboard heading (HomeKeys.dashboardHeading) is visible — registration lands on home screen
      },
    );

    patrolTest(
      'Register flow — password mismatch shows error',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // TODO: tap the register link (LoginKeys.registerLink) and wait for UI to settle

        // Fill step 1
        // TODO: enter 'Test' into the first name field (RegisterKeys.firstNameField)
        // TODO: enter 'User' into the last name field (RegisterKeys.lastNameField)
        // TODO: enter 'test@test.com' into the email field (RegisterKeys.registerEmailField)
        // TODO: enter '+1 555 000 0000' into the phone field (RegisterKeys.phoneField)
        // TODO: tap the continue button (RegisterKeys.nextStep1Button) and wait for UI to settle

        // Step 2 with mismatched passwords
        // TODO: enter 'testuser' into the username field (RegisterKeys.usernameField)
        // TODO: enter 'Password123!' into the password field (RegisterKeys.registerPasswordField)
        // TODO: enter 'DifferentPass!' into the confirm password field (RegisterKeys.confirmPasswordField)
        // TODO: tap the review button (RegisterKeys.nextStep2Button) and wait for UI to settle

        // TODO: verify that the text 'Passwords do not match' appears on screen
      },
    );

    patrolTest(
      'Home screen — bottom navigation tabs work correctly',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login first
        // TODO: enter 'officer@bsbpatrol.com' into the email field (LoginKeys.emailField)
        // TODO: enter 'password123' into the password field (LoginKeys.passwordField)
        // TODO: tap the login button (LoginKeys.loginButton) and wait for UI to settle

        // TODO: verify that the dashboard welcome greeting (HomeKeys.dashboardWelcomeGreeting) is visible

        // Navigate to Explore tab
        // TODO: tap the explore tab (HomeKeys.exploreTab) and wait for UI to settle
        // TODO: verify that the explore subtitle (ExploreKeys.exploreSubtitle) is visible

        // Navigate to Alerts tab
        // TODO: tap the notifications tab (HomeKeys.notificationsTab) and wait for UI to settle
        // TODO: verify that the notifications heading (NotificationsKeys.notificationsHeading) is visible

        // Navigate to Profile tab
        // TODO: tap the profile tab (HomeKeys.profileTab) and wait for UI to settle
        // TODO: verify that the profile name (ProfileKeys.profileName) is visible
        // TODO: verify that the profile username (ProfileKeys.profileUsername) is visible

        // Navigate back to Dashboard
        // TODO: tap the dashboard tab (HomeKeys.dashboardTab) and wait for UI to settle
        // TODO: verify that the dashboard welcome greeting (HomeKeys.dashboardWelcomeGreeting) is visible again
      },
    );

    patrolTest(
      'Profile — logout navigates back to login',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login
        // TODO: enter 'officer@bsbpatrol.com' into the email field (LoginKeys.emailField)
        // TODO: enter 'password123' into the password field (LoginKeys.passwordField)
        // TODO: tap the login button (LoginKeys.loginButton) and wait for UI to settle

        // TODO: tap the profile tab (HomeKeys.profileTab) and wait for UI to settle

        // TODO: scroll to the logout button (ProfileKeys.logoutButton) to bring it into view and wait for UI to settle
        // TODO: tap the logout button (ProfileKeys.logoutButton) and wait for UI to settle

        // TODO: verify that the logout dialog title (ProfileKeys.logoutDialogTitle) is visible
        // TODO: verify that the logout dialog message (ProfileKeys.logoutDialogMessage) is visible

        // TODO: tap the confirm logout button (ProfileKeys.confirmLogoutButton) and wait for UI to settle

        // TODO: verify that the login subtitle (LoginKeys.loginSubtitle) is visible — back on login screen
      },
    );

    patrolTest(
      'Profile — accept system file access permission when changing profile picture',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login
        await $(#emailField).enterText('officer@bsbpatrol.com');
        await $(#passwordField).enterText('password123');
        await $(#loginButton).tap();
        await $.pumpAndSettle();

        // Go to Profile tab
        await $(find.text('Profile')).tap();
        await $.pumpAndSettle();

        // Tap on the avatar to trigger a native permission dialog
        await $(#changeProfilePictureButton).tap();
        await $.pumpAndSettle();

        // Handle the native system permission dialog with Patrol - Android Only
        if (await $.platformAutomator.android.isPermissionDialogVisible()) {
          await $.platformAutomator.android.grantPermissionWhenInUse();
        }

        // Give the app a moment to react to the granted permission
        await $.pump(const Duration(seconds: 1));

        // We only assert that we're still on the Profile screen;
        // the system dialog has been handled without crashing.
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('@johndoe'), findsOneWidget);
      },
    );

    patrolTest(
      'Notifications — mark all as read',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login
        // TODO: enter 'officer@bsbpatrol.com' into the email field (LoginKeys.emailField)
        // TODO: enter 'password123' into the password field (LoginKeys.passwordField)
        // TODO: tap the login button (LoginKeys.loginButton) and wait for UI to settle

        // TODO: tap the notifications tab (HomeKeys.notificationsTab) and wait for UI to settle

        // TODO: verify that the unread count badge (NotificationsKeys.unreadCountBadge) is visible

        // TODO: tap the mark all read button (NotificationsKeys.markAllReadButton) and wait for UI to settle

        // TODO: verify that the unread count badge (NotificationsKeys.unreadCountBadge) is no longer visible
        // TODO: verify that the mark all read button (NotificationsKeys.markAllReadButton) is no longer visible
      },
    );
  });
}
