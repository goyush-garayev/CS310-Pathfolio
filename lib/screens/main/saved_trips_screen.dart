import 'package:flutter/material.dart';
import '../../data/trip_store.dart';
import '../../models/trip.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/cards.dart';
import '../../widgets/common.dart';

/// Trips tab: list of saved trips as Cards. Each card can be removed.
class SavedTripsScreen extends StatelessWidget {
  const SavedTripsScreen({super.key});

  void _remove(BuildContext context, Trip trip) {
    final store = TripStore.instance;
    final index = store.trips.indexOf(trip);
    store.removeTrip(trip);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${trip.city} trip removed'),
          action: SnackBarAction(
            label: 'Undo',
            textColor: AppColors.accentSoft,
            onPressed: () => store.insertTrip(index, trip),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final store = TripStore.instance;

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final trips = store.trips;
          return ResponsiveBody(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenH, AppSpacing.sm, AppSpacing.screenH, 110),
              children: [
                ScreenHeader(
                  title: 'Saved trips',
                  subtitle: trips.isEmpty
                      ? 'No trips yet'
                      : '${trips.length} trips saved on this phone',
                ),
                const Gap(AppSpacing.lg),
                if (trips.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
                    child: Column(
                      children: [
                        Icon(Icons.luggage_outlined,
                            size: 48, color: AppColors.textMuted),
                        Gap(AppSpacing.sm),
                        Text('Plan a trip and it will show up here.',
                            style: AppTextStyles.bodyMuted,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                for (final trip in trips) ...[
                  // Swipe left OR tap the trash icon to remove
                  Dismissible(
                    key: ValueKey(trip.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: const Icon(Icons.delete_outline,
                          color: AppColors.white),
                    ),
                    onDismissed: (_) => _remove(context, trip),
                    child: TripCard(
                      trip: trip,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.itinerary,
                          arguments: trip.id),
                      onRemove: () => _remove(context, trip),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                ],
                const Gap(AppSpacing.sm),
                PrimaryButton(
                  label: 'Plan a new trip',
                  icon: Icons.add,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.preferences),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
