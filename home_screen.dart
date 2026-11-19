import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../data/trip_store.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/cards.dart';
import '../../widgets/common.dart';

/// Explore tab: search, current plan, start new plan, city ideas.
class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenTrips;
  const HomeScreen({super.key, required this.onOpenTrips});

  @override
  Widget build(BuildContext context) {
    final store = TripStore.instance;

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final current = store.currentTrip;
          return ResponsiveBody(
            child: ListView(
              // extra bottom space so the floating nav bar doesn't cover content
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenH, AppSpacing.sm, AppSpacing.screenH, 110),
              children: [
                // Header
                Row(
                  children: [
                    const Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text('Where to?', style: AppTextStyles.display),
                      ),
                    ),
                    const Gap.h(AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: onOpenTrips,
                      icon: const Icon(Icons.bookmark_border,
                          size: 18, color: AppColors.text),
                      label: Text('${store.trips.length} trips',
                          style: AppTextStyles.chip),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.lg),
                // Search
                TextField(
                  style: AppTextStyles.body,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) =>
                      Navigator.pushNamed(context, AppRoutes.preferences),
                  decoration: InputDecoration(
                    hintText: 'Cities, interests, trip ideas...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.text),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                      borderSide:
                          const BorderSide(color: AppColors.text, width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                      borderSide:
                          const BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                ),
                const Gap(AppSpacing.lg),
                // Plan card
                SurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.near_me_outlined,
                              size: 20, color: AppColors.text),
                          Gap.h(AppSpacing.sm),
                          Text('PathFolio', style: AppTextStyles.sectionTitle),
                        ],
                      ),
                      const Gap(AppSpacing.md),
                      if (current != null) ...[
                        _PlanRow(
                          icon: Icons.near_me_outlined,
                          tileColor: AppColors.accent,
                          title: '${current.city} · ${current.dateRange}',
                          subtitle: 'Continue your itinerary',
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.itinerary,
                              arguments: current.id),
                        ),
                        const Divider(
                            height: AppSpacing.xl, color: AppColors.border),
                      ],
                      _PlanRow(
                        icon: Icons.add,
                        tileColor: AppColors.primarySoft,
                        title: 'Start a new plan',
                        subtitle: 'Takes under a minute',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.preferences),
                      ),
                    ],
                  ),
                ),
                const Gap(AppSpacing.lg),
                // Banner
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: const Text(
                    'Saved trips work offline on your phone',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.sectionTitle,
                  ),
                ),
                const Gap(AppSpacing.xl),
                // Section title
                const Row(
                  children: [
                    IconTile(icon: Icons.place_outlined),
                    Gap.h(AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Start somewhere new',
                              style: AppTextStyles.bodyMuted),
                          Text('Discover cities', style: AppTextStyles.h2),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.md),
                // City cards (network images), scroll sideways
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: SampleData.cities.length,
                    separatorBuilder: (_, __) => const Gap.h(AppSpacing.md),
                    itemBuilder: (context, i) => CityCard(
                      city: SampleData.cities[i],
                      dark: i.isEven,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.preferences),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PlanRow extends StatelessWidget {
  final IconData icon;
  final Color tileColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PlanRow({
    required this.icon,
    required this.tileColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Row(
        children: [
          IconTile(icon: icon, background: tileColor, size: 52),
          const Gap.h(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(subtitle, style: AppTextStyles.bodyMuted),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
