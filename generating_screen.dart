import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/trip_store.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/common.dart';

/// Loading screen while the plan is made.
/// Step 2: fake progress with a timer. Step 3+: real Gemini API call.
class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({super.key});

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();
}

class _GeneratingScreenState extends State<GeneratingScreen> {
  static const _steps = [
    'Reading your preferences',
    'Finding places',
    'Checking the weather',
    'Building your days',
  ];

  int _done = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 700), (t) {
      if (!mounted) return;
      if (_done < _steps.length) {
        setState(() => _done++);
      } else {
        t.cancel();
        final trip = TripStore.instance.currentTrip;
        Navigator.pushReplacementNamed(context, AppRoutes.itinerary,
            arguments: trip?.id);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _done / _steps.length;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveBody(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenH),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          color: AppColors.accent,
                          backgroundColor: AppColors.primarySoft,
                        ),
                        const Center(
                          child: Icon(Icons.near_me_outlined,
                              size: 40, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.xxl),
                  const Text('Building your plan',
                      style: AppTextStyles.h2, textAlign: TextAlign.center),
                  const Gap(AppSpacing.sm),
                  const Text(
                    'This takes a few seconds. We check places, opening hours and the weather.',
                    style: AppTextStyles.bodyMuted,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(AppSpacing.xxl),
                  for (var i = 0; i < _steps.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Icon(
                            i < _done
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: i < _done
                                ? AppColors.success
                                : AppColors.border,
                            size: 22,
                          ),
                          const Gap.h(AppSpacing.md),
                          Expanded(
                            child: Text(
                              _steps[i],
                              style: AppTextStyles.body.copyWith(
                                color: i < _done
                                    ? AppColors.text
                                    : AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Gap(AppSpacing.lg),
                  const Text('Plans come from the Gemini API (Step 3).',
                      style: AppTextStyles.small),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: SecondaryButton(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
