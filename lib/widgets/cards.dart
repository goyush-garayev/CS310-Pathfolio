import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../models/city.dart';
import '../models/trip.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

String money(double v) =>
    v == v.roundToDouble() ? '\$${v.toInt()}' : '\$${v.toStringAsFixed(1)}';

/// Card for one activity in the itinerary. Has a remove (X) button.
class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const ActivityCard({
    super.key,
    required this.activity,
    this.onTap,
    this.onRemove,
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
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.md, AppSpacing.xs, AppSpacing.md),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Time column
                SizedBox(
                  width: 72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(activity.time, style: AppTextStyles.h3),
                      Text(activity.partOfDay, style: AppTextStyles.small),
                    ],
                  ),
                ),
                Container(
                  width: 3,
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Name + category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(activity.name,
                          style: AppTextStyles.h3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text(
                        '${activity.category} · ${activity.durationLabel}',
                        style: AppTextStyles.bodyMuted.copyWith(fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Center(
                    child: Text(money(activity.cost),
                        style: AppTextStyles.price)),
                if (onRemove != null)
                  IconButton(
                    tooltip: 'Remove',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.close,
                        size: 20, color: AppColors.textMuted),
                    onPressed: onRemove,
                  )
                else
                  const SizedBox(width: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Card for one saved trip. Has a remove (trash) button.
class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const TripCard({super.key, required this.trip, this.onTap, this.onRemove});

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.lg, AppSpacing.xs, AppSpacing.lg),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: const Icon(Icons.place_outlined,
                    color: AppColors.text, size: 22),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.city,
                        style: AppTextStyles.h3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(
                      '${trip.dateRange} · ${trip.dayCount} days · ${trip.pace}',
                      style: AppTextStyles.bodyMuted.copyWith(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(money(trip.totalCost), style: AppTextStyles.price),
                  const Text('est.', style: AppTextStyles.small),
                ],
              ),
              IconButton(
                tooltip: 'Remove trip',
                icon: const Icon(Icons.delete_outline,
                    color: AppColors.textMuted),
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// City idea card on Home. Uses a NETWORK image with a dark overlay.
class CityCard extends StatelessWidget {
  final City city;
  final bool dark; // dark green or lime fallback color
  final VoidCallback? onTap;

  const CityCard({
    super.key,
    required this.city,
    this.dark = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = dark ? AppColors.primary : AppColors.accentSoft;
    return SizedBox(
      width: 150,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: fallback,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                city.imageUrl,
                fit: BoxFit.cover,
                // If there is no internet, just show the color
                errorBuilder: (_, __, ___) => ColoredBox(color: fallback),
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : ColoredBox(
                        color: fallback,
                        child: const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.white),
                          ),
                        ),
                      ),
              ),
              // Gradient so the white text is easy to read
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00000000), Color(0xB30A3F2C)],
                  ),
                ),
              ),
              const Positioned(
                top: 14,
                left: 14,
                child: Icon(Icons.place_outlined,
                    color: AppColors.accentSoft, size: 24),
              ),
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(city.country,
                        style: AppTextStyles.small
                            .copyWith(color: AppColors.accentSoft)),
                    Text(
                      city.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.h3.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
