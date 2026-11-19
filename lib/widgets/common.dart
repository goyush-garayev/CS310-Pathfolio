import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

/// "‹ Back" link with an optional "Step 1 of 2" on the right.
class TopNav extends StatelessWidget {
  final String? step;
  final VoidCallback? onBack;

  const TopNav({super.key, this.step, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBack ?? () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left, size: 20, color: AppColors.text),
                Text('Back', style: AppTextStyles.body),
              ],
            ),
          ),
        ),
        const Spacer(),
        if (step != null) Text(step!, style: AppTextStyles.label),
      ],
    );
  }
}

/// Big title with an optional smaller subtitle.
class ScreenHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const ScreenHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h1),
        if (subtitle != null) ...[
          const Gap(AppSpacing.xs),
          Text(subtitle!, style: AppTextStyles.bodyMuted),
        ],
      ],
    );
  }
}

/// Light lime box with a bold title and text. Used for tips and notes.
class InfoBox extends StatelessWidget {
  final String title;
  final String text;
  final Color color;

  const InfoBox({
    super.key,
    required this.title,
    required this.text,
    this.color = AppColors.primarySoft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          const Gap(AppSpacing.xs),
          Text(text, style: AppTextStyles.bodyMuted),
        ],
      ),
    );
  }
}

/// White rounded box with border and soft shadow.
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Small rounded square with an icon inside.
class IconTile extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final double size;

  const IconTile({
    super.key,
    required this.icon,
    this.background = AppColors.accentSoft,
    this.iconColor = AppColors.text,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Icon(icon, color: iconColor, size: size * 0.5),
    );
  }
}

/// Wraps a screen body: keeps content centered and not too wide on big screens.
class ResponsiveBody extends StatelessWidget {
  final Widget child;
  const ResponsiveBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        child: child,
      ),
    );
  }
}

/// Button area fixed at the bottom of a screen.
class BottomActionBar extends StatelessWidget {
  final Widget child;
  const BottomActionBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      // heightFactor: 1 so the bar is only as tall as the button
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenH,
                AppSpacing.sm, AppSpacing.screenH, AppSpacing.lg),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// PathFolio logo image (local asset) + two-color wordmark.
class BrandLogo extends StatelessWidget {
  final double iconHeight;
  final bool showWordmark;
  final Color wordColor;

  const BrandLogo({
    super.key,
    this.iconHeight = 44,
    this.showWordmark = true,
    this.wordColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/logo.png', height: iconHeight),
        if (showWordmark) ...[
          const Gap.h(AppSpacing.sm),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: 'Path',
                  style: AppTextStyles.brand
                      .copyWith(color: AppColors.logoLime)),
              TextSpan(
                  text: 'Folio',
                  style: AppTextStyles.brand.copyWith(color: wordColor)),
            ]),
          ),
        ],
      ],
    );
  }
}
