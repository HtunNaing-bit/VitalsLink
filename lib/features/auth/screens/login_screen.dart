import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../core/utils/motion_utils.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../widgets/motion_button.dart';

/// Login screen with email/password and OAuth options
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO: Implement actual authentication
      // Example: await authService.signInWithEmail(
      //   _emailController.text,
      //   _passwordController.text,
      // );

      await AnalyticsService().trackEvent('login_attempt', parameters: {
        'method': 'email',
      });

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        // Navigate to onboarding or dashboard based on user state
        context.go('/onboarding');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid credentials. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleOAuthLogin(String provider) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO: Implement OAuth authentication
      // Example: await authService.signInWithOAuth(provider);

      await AnalyticsService().trackEvent('login_attempt', parameters: {
        'method': provider,
      });

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        context.go('/onboarding');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Authentication failed. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo and title
                    Text(
                      'VitalsLink',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(
                          duration: MotionUtils.getDuration(
                            context,
                            MotionTokens.medium,
                          ),
                        )
                        .slideY(
                          begin: -0.1,
                          end: 0,
                          duration: MotionUtils.getDuration(
                            context,
                            MotionTokens.medium,
                          ),
                        ),
                    const SizedBox(height: 8),
                    Text(
                      'AI Personal Health OS',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(
                          delay: MotionTokens.small,
                          duration: MotionUtils.getDuration(
                            context,
                            MotionTokens.medium,
                          ),
                        ),
                    const SizedBox(height: 48),

                    // Login form
                    GlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Error message
                          if (_errorMessage != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                          if (_errorMessage != null) const SizedBox(height: 16),

                          // Login button
                          MotionButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // OAuth buttons
                    Text(
                      'Or continue with',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: MotionButton(
                            onPressed: _isLoading
                                ? null
                                : () => _handleOAuthLogin('google'),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  height: 20,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.g_mobiledata,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('Google'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: MotionButton(
                            onPressed: _isLoading
                                ? null
                                : () => _handleOAuthLogin('apple'),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.apple, size: 20),
                                SizedBox(width: 8),
                                Text('Apple'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(
                          delay: MotionTokens.large,
                          duration: MotionUtils.getDuration(
                            context,
                            MotionTokens.medium,
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
