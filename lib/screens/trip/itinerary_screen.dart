import 'package:flutter/material.dart';
import '../../data/trip_store.dart';
import '../../models/activity.dart';
import '../../models/trip.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/cards.dart';
import '../../widgets/common.dart';
import '../../widgets/pill_chip.dart';
import '../../widgets/pill_nav_bar.dart';
import 'trip_args.dart';

/// Day-by-day plan of a trip. Activities are Cards and can be removed.
class ItineraryScreen extends StatefulWidget {
  final String? tripId;
  const ItineraryScreen({super.key, this.tripId});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _day = 0;
  final _store = TripStore.instance;

  Trip? get _trip => widget.tripId == null
      ? _store.currentTrip
      : _store.findTrip(widget.tripId!);

  void _removeActivity(TripDay day, Activity a) {
    final index = day.activities.indexOf(a);
    _store.removeActivity(day, a);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('${a.name} removed'),
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.accentSoft,
          onPressed: () => _store.insertActivity(day, index, a),
        ),
      ));
  }

  void _onNavTap(int i) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false,
        arguments: i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _store,
          builder: (context, _) {
            final trip = _trip;
            if (trip == null || trip.days.isEmpty) {
              return const Center(
                child: Text('This trip was removed.',
                    style: AppTextStyles.bodyMuted),
              );
            }
            final dayIndex = _day.clamp(0, trip.days.length - 1);
            final day = trip.days[dayIndex];

            return ResponsiveBody(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(AppSpacing.screenH,
                    AppSpacing.sm, AppSpacing.screenH, 110),
                children: [
                  if (Navigator.canPop(context)) const TopNav(),
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(trip.city,
                                style: AppTextStyles.h1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text(
                              '${trip.dateRange} · ${trip.dayCount} days · ${trip.pace} pace',
                              style: AppTextStyles.bodyMuted,
                            ),
                          ],
                        ),
                      ),
                      const PillChip(label: 'Saved', selected: true),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  // Weather strip
                  if (trip.weather.isNotEmpty) ...[
                    Row(
                      children: [
                        for (var i = 0; i < trip.weather.length; i++) ...[
                          if (i > 0) const Gap.h(AppSpacing.sm),
                          Expanded(child: _WeatherBox(w: trip.weather[i])),
                        ],
                      ],
                    ),
                    const Gap(AppSpacing.md),
                  ],
                  // Day tabs
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (var i = 0; i < trip.days.length; i++)
                        PillChip(
                          label: 'Day ${i + 1}',
                          selected: i == dayIndex,
                          onTap: () => setState(() => _day = i),
                        ),
                    ],
                  ),
                  const Gap(AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Day ${dayIndex + 1} · ${day.label}',
                            style: AppTextStyles.h3,
                            overflow: TextOverflow.ellipsis),
                      ),
                      GestureDetector(
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Regenerate will use the Gemini API in Step 3')),
                        ),
                        child: const Text('Regenerate day',
                            style: AppTextStyles.link),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  if (day.activities.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                      child: Text('No activities for this day yet.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMuted),
                    ),
                  // Activity cards (list of model objects)
                  for (final a in day.activities) ...[
                    ActivityCard(
                      key: ValueKey(a.id),
                      activity: a,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.activityDetails,
                        arguments: ActivityArgs(
                            tripId: trip.id,
                            dayIndex: dayIndex,
                            activityId: a.id),
                      ),
                      onRemove: () => _removeActivity(day, a),
                    ),
                    const Gap(AppSpacing.md),
                  ],
                  // Totals
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _Total(
                              label: 'Day ${dayIndex + 1} total',
                              value: money(day.total)),
                        ),
                        Expanded(
                          child: _Total(
                            label: 'Trip total (estimate)',
                            value: money(trip.totalCost),
                            end: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  SecondaryButton(
                    label: 'Add activity',
                    icon: Icons.add,
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.addActivity,
                      arguments:
                          ActivityArgs(tripId: trip.id, dayIndex: dayIndex),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: PillNavBar(currentIndex: 1, onTap: _onNavTap),
    );
  }
}

class _WeatherBox extends StatelessWidget {
  final DayWeather w;
  const _WeatherBox({required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Text(w.day, style: AppTextStyles.small),
            Text('${w.tempC}°', style: AppTextStyles.h3),
            Text(w.condition,
                style: AppTextStyles.small.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _Total extends StatelessWidget {
  final String label;
  final String value;
  final bool end;
  const _Total({required this.label, required this.value, this.end = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.small, overflow: TextOverflow.ellipsis),
        Text(value, style: AppTextStyles.h2),
      ],
    );
  }
}
