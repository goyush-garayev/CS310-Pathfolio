import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/common.dart';
import '../../widgets/segmented_selector.dart';

/// Account tab: profile, currency, language, theme, log out.
/// Settings are UI only in Step 2 (they are not saved yet).
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _currency = 'USD';
  String _language = 'English';
  String _theme = 'Light';

  static const _currencies = ['USD', 'EUR', 'TRY', 'AZN'];

  Future<void> _confirmLogOut() async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?', style: AppTextStyles.h2),
        content: const Text('You can log in again any time.',
            style: AppTextStyles.body),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Log out',
                  style: TextStyle(color: AppColors.error))),
        ],
      ),
    );
    if (yes == true && mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.welcome, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenH, AppSpacing.sm, AppSpacing.screenH, 110),
          children: [
            const ScreenHeader(title: 'Account'),
            const Gap(AppSpacing.lg),
            // Profile card
            SurfaceCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary,
                    child: Text('GG',
                        style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            color: AppColors.accentSoft,
                            fontWeight: FontWeight.w700,
                            fontSize: 18)),
                  ),
                  const Gap.h(AppSpacing.md),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Guest traveler',
                            style: AppTextStyles.h3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text('guest@pathfolio.app',
                            style: AppTextStyles.bodyMuted,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Profile editing comes in Step 3')),
                    ),
                    child: const Text('Edit', style: AppTextStyles.link),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.xl),
            // Currency
            const Text('Currency', style: AppTextStyles.label),
            const Gap(AppSpacing.sm - 2),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final c in _currencies)
                  ChoiceChip(
                    label: Text(c),
                    selected: _currency == c,
                    showCheckmark: false,
                    selectedColor: AppColors.primarySoft,
                    backgroundColor: AppColors.surface,
                    labelStyle: AppTextStyles.chip,
                    shape: StadiumBorder(
                      side: BorderSide(
                          color: _currency == c
                              ? AppColors.text
                              : AppColors.border),
                    ),
                    onSelected: (_) => setState(() => _currency = c),
                  ),
              ],
            ),
            const Gap(AppSpacing.lg),
            SegmentedSelector(
              label: 'Language',
              options: const ['English', 'Türkçe', 'Azərbaycan'],
              value: _language,
              onChanged: (v) => setState(() => _language = v),
            ),
            const Gap(AppSpacing.lg),
            SegmentedSelector(
              label: 'Theme',
              options: const ['Light', 'Dark', 'System'],
              value: _theme,
              onChanged: (v) => setState(() => _theme = v),
            ),
            const Gap(AppSpacing.xl),
            const InfoBox(
              title: 'About costs',
              text:
                  'All prices are estimates. Currency conversion uses fixed exchange rates stored in the app.',
            ),
            const Gap(AppSpacing.xl),
            SecondaryButton(
              label: 'Log out',
              icon: Icons.logout,
              foreground: AppColors.error,
              borderColor: AppColors.error,
              onPressed: _confirmLogOut,
            ),
            const Gap(AppSpacing.lg),
            const Center(
              child: Text('PathFolio v1.0 · CS310 Group 16',
                  style: AppTextStyles.small),
            ),
          ],
        ),
      ),
    );
  }
}
