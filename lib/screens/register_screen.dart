import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../keys/patrol_keys_register.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  final _step1FormKey = GlobalKey<ShadFormState>();
  final _step2FormKey = GlobalKey<ShadFormState>();

  final Map<String, String> _formData = {};
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const _steps = ['Personal Info', 'Account Setup', 'Review'];

  void _nextStep() {
    final isValid = switch (_currentStep) {
      0 => _step1FormKey.currentState?.saveAndValidate() ?? false,
      1 => _step2FormKey.currentState?.saveAndValidate() ?? false,
      _ => true,
    };

    if (isValid) {
      if (_currentStep == 0) {
        final values = _step1FormKey.currentState?.value ?? {};
        _formData.addAll(values.map((k, v) => MapEntry(k, v.toString())));
      } else if (_currentStep == 1) {
        final values = _step2FormKey.currentState?.value ?? {};
        _formData.addAll(values.map((k, v) => MapEntry(k, v.toString())));
      }
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => _isLoading = false);
    if (mounted) {
      ShadToaster.of(context).show(
        const ShadToast(
          title: Text('Account created!'),
          description: Text('Welcome aboard. Please sign in.'),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: _currentStep > 0 ? _prevStep : () => Navigator.pop(context),
        ),
        title: Text(key: RegisterKeys.registerAppBarTitle, 'Create Account', style: theme.textTheme.h4),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStepIndicator(theme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: KeyedSubtree(
                    key: ValueKey(_currentStep),
                    child: switch (_currentStep) {
                      0 => _buildStep1(theme),
                      1 => _buildStep2(theme),
                      _ => _buildStep3(theme),
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(ShadThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(_steps.length, (index) {
              final isCompleted = index < _currentStep;
              final isCurrent = index == _currentStep;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < _steps.length - 1 ? 4 : 0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? theme.colorScheme.primary
                          : theme.colorScheme.muted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key: RegisterKeys.stepCounter,
                'Step ${_currentStep + 1} of ${_steps.length}',
                style: theme.textTheme.muted,
              ),
              Text(
                _steps[_currentStep],
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(ShadThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(key: RegisterKeys.step1Heading, 'Personal Information', style: theme.textTheme.h3),
        const SizedBox(height: 6),
        Text('Tell us a bit about yourself', style: theme.textTheme.muted),
        const SizedBox(height: 24),
        ShadCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ShadForm(
              key: _step1FormKey,
              child: Column(
                children: [
                  ShadInputFormField(
                    key: RegisterKeys.firstNameField,
                    id: 'firstName',
                    label: const Text('First Name'),
                    placeholder: const Text('John'),
                    validator: (v) =>
                        v.isEmpty ? 'First name is required' : null,
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    key: RegisterKeys.lastNameField,
                    id: 'lastName',
                    label: const Text('Last Name'),
                    placeholder: const Text('Doe'),
                    validator: (v) =>
                        v.isEmpty ? 'Last name is required' : null,
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    key: RegisterKeys.registerEmailField,
                    id: 'email',
                    label: const Text('Email'),
                    placeholder: const Text('john@example.com'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v.isEmpty) return 'Email is required';
                      if (!v.contains('@') || !v.contains('.')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    key: RegisterKeys.phoneField,
                    id: 'phone',
                    label: const Text('Phone Number'),
                    placeholder: const Text('+1 (555) 000-0000'),
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        v.isEmpty ? 'Phone number is required' : null,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ShadButton(
          key: RegisterKeys.nextStep1Button,
          width: double.infinity,
          onPressed: _nextStep,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Continue'),
              SizedBox(width: 8),
              Icon(LucideIcons.arrowRight, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2(ShadThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(key: RegisterKeys.step2Heading, 'Account Setup', style: theme.textTheme.h3),
        const SizedBox(height: 6),
        Text('Create your login credentials', style: theme.textTheme.muted),
        const SizedBox(height: 24),
        ShadCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ShadForm(
              key: _step2FormKey,
              child: Column(
                children: [
                  ShadInputFormField(
                    key: RegisterKeys.usernameField,
                    id: 'username',
                    label: const Text('Username'),
                    placeholder: const Text('johndoe'),
                    validator: (v) {
                      if (v.isEmpty) return 'Username is required';
                      if (v.length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    key: RegisterKeys.registerPasswordField,
                    id: 'password',
                    label: const Text('Password'),
                    placeholder: const Text('Create a strong password'),
                    obscureText: _obscurePassword,
                    trailing: ShadButton.ghost(
                      onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword),
                      child: Icon(
                        _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                        size: 16,
                      ),
                    ),
                    validator: (v) {
                      if (v.isEmpty) return 'Password is required';
                      if (v.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    key: RegisterKeys.confirmPasswordField,
                    id: 'confirmPassword',
                    label: const Text('Confirm Password'),
                    placeholder: const Text('Re-enter your password'),
                    obscureText: _obscureConfirmPassword,
                    trailing: ShadButton.ghost(
                      onPressed: () => setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword),
                      child: Icon(
                        _obscureConfirmPassword
                            ? LucideIcons.eye
                            : LucideIcons.eyeOff,
                        size: 16,
                      ),
                    ),
                    validator: (v) {
                      if (v.isEmpty) return 'Please confirm your password';
                      final password = _step2FormKey
                              .currentState?.value['password']
                              ?.toString() ??
                          '';
                      if (v != password) return 'Passwords do not match';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ShadButton(
          key: RegisterKeys.nextStep2Button,
          width: double.infinity,
          onPressed: _nextStep,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Review'),
              SizedBox(width: 8),
              Icon(LucideIcons.arrowRight, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(ShadThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(key: RegisterKeys.step3Heading, 'Review & Submit', style: theme.textTheme.h3),
        const SizedBox(height: 6),
        Text('Confirm your information before submitting',
            style: theme.textTheme.muted),
        const SizedBox(height: 24),
        ShadCard(
          title: Row(
            children: [
              Icon(LucideIcons.user,
                  size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text('Personal Information', style: theme.textTheme.large),
            ],
          ),
          child: Column(
            children: [
              _buildReviewRow(theme, 'First Name',
                  _formData['firstName'] ?? '—',
                  valueKey: RegisterKeys.reviewFirstNameValue),
              _buildReviewRow(theme, 'Last Name',
                  _formData['lastName'] ?? '—',
                  valueKey: RegisterKeys.reviewLastNameValue),
              _buildReviewRow(theme, 'Email', _formData['email'] ?? '—',
                  valueKey: RegisterKeys.reviewEmailValue),
              _buildReviewRow(theme, 'Phone', _formData['phone'] ?? '—'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ShadCard(
          title: Row(
            children: [
              Icon(LucideIcons.settings,
                  size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text('Account Details', style: theme.textTheme.large),
            ],
          ),
          child: Column(
            children: [
              _buildReviewRow(
                  theme, 'Username', '@${_formData['username'] ?? '—'}',
                  valueKey: RegisterKeys.reviewUsernameValue),
              _buildReviewRow(theme, 'Password', '••••••••'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShadButton(
          key: RegisterKeys.submitButton,
          width: double.infinity,
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(LucideIcons.circleCheck, size: 16),
                    SizedBox(width: 8),
                    Text('Create Account'),
                  ],
                ),
        ),
        const SizedBox(height: 12),
        ShadButton.outline(
          width: double.infinity,
          onPressed: _prevStep,
          child: const Text('Go Back & Edit'),
        ),
      ],
    );
  }

  Widget _buildReviewRow(ShadThemeData theme, String label, String value,
      {Key? valueKey}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: theme.textTheme.muted.copyWith(fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                key: valueKey,
                style:
                    theme.textTheme.p.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
