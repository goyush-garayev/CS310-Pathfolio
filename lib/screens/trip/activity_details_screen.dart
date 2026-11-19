import 'package:flutter/material.dart';
import '../../data/trip_store.dart';
import '../../models/activity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/cards.dart';
import '../../widgets/common.dart';
import '../../widgets/pill_chip.dart';
import 'trip_args.dart';

/// Details of one activity: cost, description, tip, maps, reorder, remove.
class ActivityDetailsScreen extends StatelessWidget {
  final ActivityArgs args;
  const ActivityDetailsScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final store = TripStore.instance;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final trip = store.findTrip(args.tripId);
            final day = trip?.days[args.dayIndex];
            Activity? a;
            for (final x in day?.activities ?? <Activity>[]) {
              if (x.id == args.activityId) a = x;
            }
            if (trip == null || day == null || a == null) {
              return const Center(
                  child: Text('Activity not found',
                      style: AppTextStyles.bodyMuted));
            }
            final activity = a;
            final pos = day.activities.indexOf(activity);

            return ResponsiveBody(
              child: ListView(
                padding: AppSpacing.screenPadding,
                children: [
                  const TopNav(),
                  const Gap(AppSpacing.md),
                  Row(
                    children: [
                      PillChip(label: activity.category, selected: true),
                      const Gap.h(AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '${activity.time} · ${activity.durationLabel}',
                          style: AppTextStyles.bodyMuted,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  Text(activity.name, style: AppTextStyles.h1),
                  const Gap(AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text('Estimated cost',
                                style: AppTextStyles.bodyMuted)),
                        Text(money(activity.cost), style: AppTextStyles.h2),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.lg),
                  Text(
                    activity.description.isEmpty
                        ? 'No description yet.'
                        : activity.description,
                    style: AppTextStyles.body,
                  ),
                  if (activity.tip.isNotEmpty) ...[
                    const Gap(AppSpacing.lg),
                    InfoBox(title: 'Tip', text: activity.tip),
                  ],
                  const Gap(AppSpacing.lg),
                  PrimaryButton(
                    label: 'Open in Google Maps',
                    icon: Icons.map_outlined,
                    onPressed: () =>
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Maps link will be added in Step 3')),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: 'Move up',
                          icon: Icons.arrow_upward,
                          onPressed: pos > 0
                              ? () => store.moveActivity(day, activity, -1)
                              : null,
                        ),
                      ),
                      const Gap.h(AppSpacing.md),
                      Expanded(
                        child: SecondaryButton(
                          label: 'Move down',
                          icon: Icons.arrow_downward,
                          onPressed: pos < day.activities.length - 1
                              ? () => store.moveActivity(day, activity, 1)
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  SecondaryButton(
                    label: 'Remove from day',
                    icon: Icons.delete_outline,
                    foreground: AppColors.error,
                    borderColor: AppColors.error,
                    onPressed: () async {
                      final yes = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Remove ${activity.name}?'),
                          content: const Text(
                              'It will be removed from this day.'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Remove',
                                    style:
                                        TextStyle(color: AppColors.error))),
                          ],
                        ),
                      );
                      if (yes == true && context.mounted) {
                        Navigator.pop(context);
                        store.removeActivity(day, activity);
                      }
                    },
                  ),
                  const Gap(AppSpacing.xl),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
