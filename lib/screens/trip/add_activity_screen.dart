import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../data/trip_store.dart';
import '../../models/activity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/cards.dart';
import '../../widgets/common.dart';
import '../../widgets/pill_chip.dart';
import 'trip_args.dart';

/// FORM: add a new activity to a day.
/// - 5 fields with inline validation errors
/// - confirmation dialog after a valid submit
class AddActivityScreen extends StatefulWidget {
  final ActivityArgs args;
  const AddActivityScreen({super.key, required this.args});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _place = TextEditingController();
  final _time = TextEditingController();
  final _cost = TextEditingController();
  final _duration = TextEditingController(text: '1');
  String _category = 'Food';

  @override
  void dispose() {
    _name.dispose();
    _place.dispose();
    _time.dispose();
    _cost.dispose();
    _duration.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    // Shows the inline errors if something is wrong
    if (!_formKey.currentState!.validate()) return;

    final activity = Activity(
      id: 'u${DateTime.now().microsecondsSinceEpoch}',
      name: _name.text.trim(),
      category: _category,
      time: _time.text.trim(),
      durationHours: double.parse(_duration.text.trim()),
      cost: double.parse(_cost.text.trim()),
      description: _place.text.trim().isEmpty
          ? ''
          : 'Location: ${_place.text.trim()}',
    );

    // Confirmation dialog after valid submission
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add this activity?', style: AppTextStyles.h2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summary('Name', activity.name),
            _summary('Category', activity.category),
            _summary('Time', activity.time),
            _summary('Duration', activity.durationLabel),
            _summary('Cost', money(activity.cost)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Edit'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final trip = TripStore.instance.findTrip(widget.args.tripId);
    if (trip != null && widget.args.dayIndex < trip.days.length) {
      TripStore.instance.addActivity(trip.days[widget.args.dayIndex], activity);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${activity.name} added to Day ${widget.args.dayIndex + 1}')),
    );
    Navigator.pop(context);
  }

  Widget _summary(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text.rich(TextSpan(children: [
          TextSpan(text: '$k: ', style: AppTextStyles.bodyMuted),
          TextSpan(text: v, style: AppTextStyles.sectionTitle),
        ])),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveBody(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: AppSpacing.screenPadding,
              children: [
                const TopNav(),
                const Gap(AppSpacing.md),
                ScreenHeader(
                  title: 'Add activity',
                  subtitle: 'Day ${widget.args.dayIndex + 1} of your trip',
                ),
                const Gap(AppSpacing.lg),
                AppTextField(
                  label: 'Activity name',
                  hint: 'e.g. Basilica Cistern',
                  controller: _name,
                  validator: Validators.name,
                  textInputAction: TextInputAction.next,
                ),
                const Gap(AppSpacing.lg),
                AppTextField(
                  label: 'Place / address (optional)',
                  hint: 'e.g. Sultanahmet, Fatih',
                  controller: _place,
                  textInputAction: TextInputAction.next,
                ),
                const Gap(AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Start time',
                        hint: '14:30',
                        controller: _time,
                        validator: Validators.time,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const Gap.h(AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        label: 'Cost (USD)',
                        hint: '20',
                        controller: _cost,
                        validator: Validators.cost,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.lg),
                AppTextField(
                  label: 'Duration (hours)',
                  hint: '1.5',
                  controller: _duration,
                  validator: Validators.duration,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const Gap(AppSpacing.lg),
                ChipGroup(
                  title: 'Category',
                  options: SampleData.activityCategories,
                  selected: {_category},
                  onToggle: (c) => setState(() => _category = c),
                ),
                const Gap(AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: PrimaryButton(label: 'Save activity', onPressed: _submit),
      ),
    );
  }
}
