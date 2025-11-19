import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
    this.isLoading = false,
  });

  /// Google login button with default styling
  factory SocialLoginButton.google({
    Key? key,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      key: key,
      text: 'Google',
      iconPath: 'google', // Using icon instead of asset
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  /// Facebook login button with default styling
  factory SocialLoginButton.facebook({
    Key? key,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      key: key,
      text: 'Facebook',
      iconPath: 'facebook', // Using icon instead of asset
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.5),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onSurface,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(colorScheme),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildIcon(ColorScheme colorScheme) {
    // Using Material icons as placeholders
    // Replace with actual brand icons/images in production
    IconData iconData;
    Color iconColor;

    switch (iconPath) {
      case 'google':
        iconData = Icons.g_mobiledata;
        iconColor = Colors.red;
        break;
      case 'facebook':
        iconData = Icons.facebook;
        iconColor = const Color(0xFF1877F2);
        break;
      default:
        iconData = Icons.login;
        iconColor = colorScheme.onSurface;
    }

    return Icon(
      iconData,
      size: 24,
      color: iconColor,
    );
  }
}

/// Divider with text in the middle (e.g., "atau" / "or")
class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}
