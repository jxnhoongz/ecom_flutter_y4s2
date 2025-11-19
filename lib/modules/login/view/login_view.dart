import 'package:app_e_commerce/modules/login/view_model/login_view_model.dart';
import 'package:app_e_commerce/modules/register/view/register_view.dart';
import 'package:app_e_commerce/widgets/auth/auth_button.dart';
import 'package:app_e_commerce/widgets/auth/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),

                // Logo/Branding
                _buildLogo(colorScheme),

                const SizedBox(height: 32),

                // Welcome Text
                _buildWelcomeText(theme),

                const SizedBox(height: 32),

                // Username/Email Field
                AuthTextField(
                  controller: loginViewModel.usernameController.value,
                  labelText: 'Email or Phone Number',
                  hintText: 'Enter your email or phone number',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: loginViewModel.onChangeValueUsername,
                ),

                const SizedBox(height: 16),

                // Password Field
                AuthPasswordField(
                  controller: loginViewModel.passwordController.value,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  onChanged: loginViewModel.onChangeValuePassword,
                ),

                const SizedBox(height: 8),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: AuthTextButton(
                    text: 'Forgot Password?',
                    onPressed: () {
                      // TODO: Navigate to forgot password
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                AuthButton(
                  text: 'Login',
                  onPressed: () {
                    loginViewModel.onLogin();
                  },
                ),

                const SizedBox(height: 32),

                // Register Link
                AuthTextButton(
                  prefixText: "Don't have an account?",
                  text: 'Register',
                  onPressed: () {
                    Get.to(() => RegisterView());
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLogo(ColorScheme colorScheme) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          Icons.shopping_bag_outlined,
          size: 40,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildWelcomeText(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue shopping',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
