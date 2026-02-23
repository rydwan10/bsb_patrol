import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../keys/patrol_keys_login.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<ShadFormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 800));
      setState(() => _isLoading = false);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    LucideIcons.shield,
                    color: theme.colorScheme.primaryForeground,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                key: LoginKeys.loginTitle,
                'BSB Patrol',
                style: theme.textTheme.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                key: LoginKeys.loginSubtitle,
                'Sign in to continue',
                style: theme.textTheme.muted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ShadCard(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ShadForm(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ShadInputFormField(
                          key: LoginKeys.emailField,
                          id: 'email',
                          label: const Text('Email'),
                          placeholder: const Text('name@example.com'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v.isEmpty) return 'Email is required';
                            if (!v.contains('@') || !v.contains('.')) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ShadInputFormField(
                          key: LoginKeys.passwordField,
                          id: 'password',
                          label: const Text('Password'),
                          placeholder: const Text('Enter your password'),
                          obscureText: _obscurePassword,
                          trailing: ShadButton.ghost(
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                            child: Icon(
                              _obscurePassword
                                  ? LucideIcons.eye
                                  : LucideIcons.eyeOff,
                              size: 16,
                            ),
                          ),
                          validator: (v) {
                            if (v.isEmpty) return 'Password is required';
                            if (v.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ShadButton(
                          key: LoginKeys.loginButton,
                          width: double.infinity,
                          onPressed: _isLoading ? null : _handleLogin,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: theme.textTheme.muted,
                  ),
                  ShadButton.link(
                    key: LoginKeys.registerLink,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
