// lib/features/auth/presentation/pages/sign_up_page.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_shared_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validateInputs() {
    final email = _emailCtrl.text.trim();
    final pw = _passwordCtrl.text;
    final cpw = _confirmCtrl.text;

    if (email.isEmpty) return 'Please enter your email address.';
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    if (pw.isEmpty) return 'Please enter a password.';
    if (pw.length < 6) return 'Password must be at least 6 characters.';
    if (cpw.isEmpty) return 'Please confirm your password.';
    if (pw != cpw) return 'Passwords do not match.';
    return null;
  }

  Future<void> _handleSignUp() async {
    final error = _validateInputs();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.accent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Replace with real auth
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Go back to login — user can now sign in with their new account
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created! Please sign in.'),
        backgroundColor: Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthBackAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                Image.asset(
                  'assets/images/app_logo.png',
                  height: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Text(
                    'GlowUp',
                    style: tt.headlineMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Create your\nAccount',
                  style: tt.headlineLarge?.copyWith(height: 1.2),
                ),

                const SizedBox(height: 10),

                Text(
                  'Sign up to get started with GlowUp',
                  style: tt.bodyMedium,
                ),

                const SizedBox(height: 40),

                Text(
                  'Email',
                  style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  controller: _emailCtrl,
                  hint: 'example@gmail.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                ),

                const SizedBox(height: 24),

                Text(
                  'Password',
                  style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  controller: _passwordCtrl,
                  hint: 'At least 6 characters',
                  icon: Icons.lock_outline,
                  obscure: _obscurePassword,
                  autofillHints: const [AutofillHints.newPassword],
                  onToggleObscure: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),

                const SizedBox(height: 24),

                Text(
                  'Confirm Password',
                  style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  controller: _confirmCtrl,
                  hint: 'Repeat your password',
                  icon: Icons.lock_reset_outlined,
                  obscure: _obscureConfirmPassword,
                  onToggleObscure: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                ),

                const SizedBox(height: 40),

                AuthPrimaryButton(
                  label: 'Create Account',
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _handleSignUp,
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: tt.bodyMedium),
                    GestureDetector(
                      // Pop back to the login page that's already on the stack
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Log In',
                        style: tt.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
