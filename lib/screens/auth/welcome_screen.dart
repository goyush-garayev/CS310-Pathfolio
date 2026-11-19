import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/common.dart';

/// First screen: logo, slogan, Sign up / Log in / Continue as guest.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Decorative circles from the design
          Positioned(
            top: -size.width * 0.25,
            right: -size.width * 0.25,
            child: _circle(size.width * 0.85, AppColors.accent),
          ),
          Positioned(
            bottom: -size.width * 0.15,
            left: -size.width * 0.25,
            child: _circle(size.width * 0.6, AppColors.accentSoft),
          ),
          SafeArea(
            child: ResponsiveBody(
              child: LayoutBuilder(
                builder: (context, c) => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl),
                  child: ConstrainedBox(
                    // At least screen height, so buttons stay at the bottom
                    constraints: BoxConstraints(minHeight: c.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 3),
                          const BrandLogo(iconHeight: 48),
                          const Gap(AppSpacing.lg),
                          Text(
                            'Your trip, built\naround you',
                            style: AppTextStyles.display
                                .copyWith(color: AppColors.white),
                          ),
                          const Gap(AppSpacing.md),
                          Text(
                            'Tell us what you love. We build the itinerary.',
                            style: AppTextStyles.body.copyWith(
                                color: AppColors.white, fontSize: 16),
                          ),
                          const Spacer(flex: 4),
                          const Gap(AppSpacing.xxl),
                          PrimaryButton(
                            label: 'Sign up',
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.signUp),
                          ),
                          const Gap(AppSpacing.md),
                          SecondaryButton(
                            label: 'Log in',
                            foreground: AppColors.white,
                            borderColor: AppColors.white,
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.logIn),
                          ),
                          const Gap(AppSpacing.sm),
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, AppRoutes.main),
                              child: Text(
                                'Continue as guest',
                                style: AppTextStyles.link.copyWith(
                                  color: AppColors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          const Gap(AppSpacing.md),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double d, Color color) => Container(
        width: d,
        height: d,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
