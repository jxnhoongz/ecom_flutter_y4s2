import 'package:app_e_commerce/modules/register/view_model/register_view_model.dart';
import 'package:app_e_commerce/widgets/auth/auth_button.dart';
import 'package:app_e_commerce/widgets/auth/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final registerViewModel = Get.put(RegisterViewModel());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Logo/Branding
                _buildLogo(colorScheme),

                const SizedBox(height: 24),

                // Title Text
                _buildTitleText(theme),

                const SizedBox(height: 32),

                // Username Field
                AuthTextField(
                  controller: registerViewModel.usernameController.value,
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icons.person_outline,
                  onChanged: registerViewModel.onChangeValueUsername,
                ),

                const SizedBox(height: 16),

                // First Name & Last Name Row
                Row(
                  children: [
                    Expanded(
                      child: AuthTextField(
                        controller: registerViewModel.firstNameController.value,
                        labelText: 'First Name',
                        hintText: 'First name',
                        prefixIcon: Icons.badge_outlined,
                        onChanged: registerViewModel.onChangeValueFirstName,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AuthTextField(
                        controller: registerViewModel.lastNameController.value,
                        labelText: 'Last Name',
                        hintText: 'Last name',
                        prefixIcon: Icons.badge_outlined,
                        onChanged: registerViewModel.onChangeValueLastName,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Email Field
                AuthTextField(
                  controller: registerViewModel.emailController.value,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: registerViewModel.onChangeValueEmail,
                ),

                const SizedBox(height: 16),

                // Phone Number Field
                AuthTextField(
                  controller: registerViewModel.phoneNumberController.value,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  onChanged: registerViewModel.onChangeValuePhoneNumber,
                ),

                const SizedBox(height: 16),

                // Password Field
                AuthPasswordField(
                  controller: registerViewModel.passwordController.value,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  textInputAction: TextInputAction.next,
                  onChanged: registerViewModel.onChangeValuePassword,
                ),

                const SizedBox(height: 16),

                // Confirm Password Field
                AuthPasswordField(
                  controller: registerViewModel.confirmPasswordController.value,
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  onChanged: registerViewModel.onChangeValueConfirmPassword,
                ),

                const SizedBox(height: 16),

                // Terms & Conditions Checkbox
                _buildTermsCheckbox(theme, colorScheme),

                const SizedBox(height: 24),

                // Register Button
                AuthButton(
                  text: 'Register',
                  onPressed: () {
                    registerViewModel.onRegister();
                  },
                ),

                const SizedBox(height: 32),

                // Login Link
                AuthTextButton(
                  prefixText: 'Already have an account?',
                  text: 'Login',
                  onPressed: () {
                    Get.back();
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
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          Icons.shopping_bag_outlined,
          size: 32,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildTitleText(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Create Account',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign up to start shopping',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: false, // TODO: Connect to ViewModel
            onChanged: (value) {
              // TODO: Update terms acceptance
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  // TODO: Add gesture recognizer for tap
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  // TODO: Add gesture recognizer for tap
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
