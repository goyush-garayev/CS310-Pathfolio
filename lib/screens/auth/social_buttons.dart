import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';

/// "—— or ——" line between the form and the social buttons.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text('or', style: AppTextStyles.label),
        ),
        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}

/// Google and Apple buttons. UI only for now.
class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  void _notReady(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Social login will be added in Step 3')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SecondaryButton(
          label: 'Continue with Google',
          icon: Icons.g_mobiledata,
          onPressed: () => _notReady(context),
        ),
        const SizedBox(height: AppSpacing.md),
        SecondaryButton(
          label: 'Continue with Apple',
          icon: Icons.apple,
          onPressed: () => _notReady(context),
        ),
      ],
    );
  }
}
