import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

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
        expect(find.text('BSB Patrol'), findsWidgets);
        expect(find.text('Sign in to continue'), findsOneWidget);

        // Enter email
        await $(#emailField).enterText('officer@bsbpatrol.com');
        await $.pumpAndSettle();

        // Enter password
        await $(#passwordField).enterText('password123');
        await $.pumpAndSettle();

        // Tap Sign In
        await $(#loginButton).tap();
        await $.pumpAndSettle();

        // Verify home screen is shown
        expect(find.text('Dashboard'), findsOneWidget);
        expect(find.text('Good morning, Officer!'), findsOneWidget);
      },
    );

    patrolTest(
      'Login flow — validation errors shown on empty submit',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Tap Sign In without filling fields
        await $(#loginButton).tap();
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

        await $(#emailField).enterText('not-an-email');
        await $(#passwordField).enterText('password123');
        await $(#loginButton).tap();
        await $.pumpAndSettle();

        expect(find.text('Enter a valid email address'), findsOneWidget);
      },
    );

    patrolTest(
      'Navigate to register screen from login',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Tap register link
        await $(#registerLink).tap();
        await $.pumpAndSettle();

        // Verify register screen is shown at step 1
        expect(find.text('Create Account'), findsOneWidget);
        expect(find.text('Personal Information'), findsOneWidget);
        expect(find.text('Step 1 of 3'), findsOneWidget);
      },
    );

    patrolTest(
      'Register flow — Step 1 validation',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        await $(#registerLink).tap();
        await $.pumpAndSettle();

        // Try to proceed without filling step 1
        await $(#nextStep1Button).tap();
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
        await $(#registerLink).tap();
        await $.pumpAndSettle();

        // ── Step 1: Personal Info ──
        expect(find.text('Step 1 of 3'), findsOneWidget);

        await $(#firstNameField).enterText('Jane');
        await $.pumpAndSettle();
        await $(#lastNameField).enterText('Smith');
        await $.pumpAndSettle();
        await $(#registerEmailField).enterText('jane@bsbpatrol.com');
        await $.pumpAndSettle();
        await $(#phoneField).enterText('+1 555 000 1234');
        await $.pumpAndSettle();

        await $(#nextStep1Button).tap();
        await $.pumpAndSettle();

        // ── Step 2: Account Setup ──
        expect(find.text('Step 2 of 3'), findsOneWidget);
        expect(find.text('Account Setup'), findsOneWidget);

        await $(#usernameField).enterText('janesmith');
        await $.pumpAndSettle();
        await $(#registerPasswordField).enterText('SecurePass1!');
        await $.pumpAndSettle();
        await $(#confirmPasswordField).enterText('SecurePass1!');
        await $.pumpAndSettle();

        await $(#nextStep2Button).tap();
        await $.pumpAndSettle();

        // ── Step 3: Review ──
        expect(find.text('Step 3 of 3'), findsOneWidget);
        expect(find.text('Review & Submit'), findsOneWidget);
        expect(find.text('Jane'), findsOneWidget);
        expect(find.text('Smith'), findsOneWidget);
        expect(find.text('jane@bsbpatrol.com'), findsOneWidget);
        expect(find.text('@janesmith'), findsOneWidget);

        await $(#submitButton).tap();
        await $.pumpAndSettle();

        // After successful registration, lands on home screen
        expect(find.text('Dashboard'), findsOneWidget);
      },
    );

    patrolTest(
      'Register flow — password mismatch shows error',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        await $(#registerLink).tap();
        await $.pumpAndSettle();

        // Fill step 1
        await $(#firstNameField).enterText('Test');
        await $(#lastNameField).enterText('User');
        await $(#registerEmailField).enterText('test@test.com');
        await $(#phoneField).enterText('+1 555 000 0000');
        await $(#nextStep1Button).tap();
        await $.pumpAndSettle();

        // Step 2 with mismatched passwords
        await $(#usernameField).enterText('testuser');
        await $(#registerPasswordField).enterText('Password123!');
        await $(#confirmPasswordField).enterText('DifferentPass!');
        await $(#nextStep2Button).tap();
        await $.pumpAndSettle();

        expect(find.text('Passwords do not match'), findsOneWidget);
      },
    );

    patrolTest(
      'Home screen — bottom navigation tabs work correctly',
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        // Login first
        await $(#emailField).enterText('officer@bsbpatrol.com');
        await $(#passwordField).enterText('password123');
        await $(#loginButton).tap();
        await $.pumpAndSettle();

        // Verify on Dashboard tab
        expect(find.text('Good morning, Officer!'), findsOneWidget);

        // Navigate to Explore tab
        await $(find.text('Explore')).tap();
        await $.pumpAndSettle();
        expect(find.text('Browse patrol zones, officers & reports'),
            findsOneWidget);

        // Navigate to Alerts tab
        await $(find.text('Alerts')).tap();
        await $.pumpAndSettle();
        expect(find.text('Notifications'), findsWidgets);

        // Navigate to Profile tab
        await $(find.text('Profile')).tap();
        await $.pumpAndSettle();
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('@johndoe'), findsOneWidget);

        // Navigate back to Dashboard
        await $(find.text('Dashboard')).tap();
        await $.pumpAndSettle();
        expect(find.text('Good morning, Officer!'), findsOneWidget);
      },
    );

    patrolTest(
      'Profile — logout navigates back to login',
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

        // Scroll the logout button into view before tapping
        await $(#logoutButton).scrollTo();
        await $.pumpAndSettle();

        // Tap Sign Out
        await $(#logoutButton).tap();
        await $.pumpAndSettle();

        // Confirm dialog appears
        expect(find.text('Sign Out'), findsWidgets);
        expect(find.text('Are you sure you want to sign out of BSB Patrol?'),
            findsOneWidget);

        // Confirm logout
        await $(#confirmLogoutButton).tap();
        await $.pumpAndSettle();

        // Back on login screen
        expect(find.text('Sign in to continue'), findsOneWidget);
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
        await $(#emailField).enterText('officer@bsbpatrol.com');
        await $(#passwordField).enterText('password123');
        await $(#loginButton).tap();
        await $.pumpAndSettle();

        // Go to Alerts tab
        await $(find.text('Alerts')).tap();
        await $.pumpAndSettle();

        // Verify unread badge exists
        expect(find.text('3 new'), findsOneWidget);

        // Tap mark all read
        await $(find.text('Mark all read')).tap();
        await $.pumpAndSettle();

        // Badge should be gone
        expect(find.text('3 new'), findsNothing);
        expect(find.text('Mark all read'), findsNothing);
      },
    );
  });
}
